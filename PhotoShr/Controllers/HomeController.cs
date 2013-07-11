using PhotoShr.Models;
using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Transactions;
using System.Web;
using System.Web.Mvc;

namespace PhotoShr.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Message = "Share your photos with our awesome PhotoShr community";
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
        /*Installing fake data*/
        private static Random random = new Random((int)DateTime.Now.Ticks);//thanks to McAden
        private string RandomString(int size)
        {
            StringBuilder builder = new StringBuilder();
            char ch;
            for (int i = 0; i < size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }

            return builder.ToString();
        }


        photoshareEntities db = new photoshareEntities();

        public ActionResult InstallFakeUsers()
        {
            //fake users
            for (int count = 0; count < 30; count++)
            {
                using (TransactionScope scope = new TransactionScope())
                {

                    membership _m = new membership
                    {
                        email = RandomString(6) + "@" + RandomString(6) + ".com",
                        joined_date = DateTime.Now.AddMonths(-1).AddDays(count),
                        is_approved = "Y",
                        username = "demouser" + (count + 1).ToString(),
                        password = "demopassword" + (count + 1).ToString()
                    };
                    db.memberships.Add(_m);
                    db.SaveChanges();

                    user _u = new user
                    {
                        membership = _m,
                        last_name = RandomString(6),
                        first_name = RandomString(6),
                        gender = Gender.Unspecified.ToString(),                        
                        about = RandomString(200)
                    };
                    db.users.Add(_u);
                    db.SaveChanges();
                    scope.Complete();
                }
            }
            return RedirectToAction("Index", "User");
        }

        public ActionResult GenerateFakePhotos()
        {

            List<user> users;
            using (var db2 = new photoshareEntities())
            {
                users = db2.users.ToList();
            }

            foreach (user u in users)
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    for (int i = 0; i < 10; i++)
                    {
                        int cat_id = new Random().Next(1, 21);
                        int randDays = new Random().Next(1, 28);

                        photo p = new photo
                        {

                            uploaded_date = DateTime.Now.AddMonths(-1).AddDays(randDays),
                            description = RandomString(200),
                            name = RandomString(10),
                            photo_category = cat_id,
                            tags = RandomString(5) + "," + RandomString(5) + "," + RandomString(5),
                            user_id = u.id,
                            views_count = 0,
                            photo_url_o = string.Format("/Images/Uploads/{0}/{1}.jpg", u.id.ToString(), (i + 1).ToString() + "_L"),
                            photo_url_m = string.Format("/Images/Uploads/{0}/{1}.jpg", u.id.ToString(), (i + 1).ToString() + "_M"),
                            photo_url_s = string.Format("/Images/Uploads/{0}/{1}.jpg", u.id.ToString(), (i + 1).ToString() + "_S")
                        };
                        db.photos.Add(p);
                    }
                    db.SaveChanges();
                    scope.Complete();
                }
            }
            return RedirectToAction("Index", "User");
        }


        public static void CreateThumbnail(string filename, ImageSize imgSize, string outFilename)
        {
            using (System.Drawing.Image img = System.Drawing.Image.FromFile(filename))
            {
                float imgWidth = (float)img.Width;
                float imgHeight = (float)img.Height;
                float sizeRatio = 0;


                if (imgSize == ImageSize.Medium)
                {
                    if (imgWidth >= imgHeight)
                    {
                        sizeRatio = 2;
                    }
                    else
                    {
                        sizeRatio = 2;
                    }
                }
                else if (imgSize == ImageSize.Small)
                {
                    if (imgWidth >= imgHeight)
                    {
                        sizeRatio = 4;
                    }
                    else
                    {
                        sizeRatio = 4;
                    }
                }

                int newWidth = Convert.ToInt32(Math.Floor((float)img.Width / sizeRatio));
                int newHeight = Convert.ToInt32(Math.Floor((float)img.Height / sizeRatio));
                using (System.Drawing.Image thumb = img.GetThumbnailImage(newWidth, newHeight, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailImageAbortCallback), IntPtr.Zero))
                {
                    if (img.RawFormat == ImageFormat.Png)
                    {
                        thumb.Save(outFilename, System.Drawing.Imaging.ImageFormat.Png);
                    }
                    else
                    {
                        thumb.Save(outFilename, System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                }
                GC.Collect();
            }
        }
        public static bool ThumbnailImageAbortCallback()
        {
            return true;
        }

        public ActionResult UplaodFakePhoto()
        {
            List<user> users;
            using (var db2 = new photoshareEntities())
            {
                users = db2.users.ToList();
            }

            foreach (user u in users)
            {
                if (u.id >= 91 && u.id < 93)
                {
                    DirectoryInfo di = new DirectoryInfo(Server.MapPath(string.Format("~/Images/Uploads/{0}/", u.id.ToString())));
                    int i = 1;
                    foreach (FileInfo file in di.GetFiles("*"))
                    {

                        var fileName = Path.GetFileNameWithoutExtension(file.Name);
                        var fileExt = Path.GetExtension(file.Name);
                        var destinationDirectory = Path.Combine(Server.MapPath("~/Images/Uploads/"), u.id.ToString());
                        var newFileTemp = i.ToString();
                        var newFileName = newFileTemp + "_L" + fileExt;
                        var path = Path.Combine(destinationDirectory, newFileName);
                        file.CopyTo(path, true);

                        var thumbMedium = newFileTemp + "_M" + fileExt;
                        CreateThumbnail(path, ImageSize.Medium, Path.Combine(destinationDirectory, thumbMedium));

                        var thumbSmall = newFileTemp + "_S" + fileExt;
                        CreateThumbnail(path, ImageSize.Small, Path.Combine(destinationDirectory, thumbSmall));

                        i++;
                        GC.Collect();

                    }
                    GC.Collect();
                }
                else {
                    continue;
                }
            }
            return RedirectToAction("Index", "User");
        }

        //F/5,6
        public ActionResult UploadFakeExif()
        {
            List<photo> _photos;
            using (var db2 = new photoshareEntities())
            {
                _photos = db2.photos.ToList();
            }
            foreach (photo p in _photos)
            {
                if (p.id == 347 || p.id == 350)
                { }
                else
                {
                    exif_data _exif = new exif_data
                    {
                        aperture = "F/" + new Random().Next(3, 22).ToString(),
                        camera = "Nikon D7000",
                        date_taken = DateTime.Now.AddYears(-2).
                        AddDays(new Random().Next(1, 360)).ToLongDateString(),

                        focal_length = new Random().Next(18, 300).ToString(),
                        iso = new Random().Next(100, 1600).ToString(),
                        shutter_speed = "1/" + new Random().Next(1, 4000).ToString(),
                        photo_id = p.id
                    };
                    db.exif_data.Add(_exif);
                    db.SaveChanges();
                }
            }

            return RedirectToAction("Index");            
        }
    }
}

