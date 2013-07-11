using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhotoShr.Models;
using System.IO;
using System.Transactions;
using PagedList;
using System.Data.Entity.Validation;
using System.Diagnostics;
using MySql.Data.MySqlClient;

namespace PhotoShr.Controllers
{
    public class PhotoController : BaseController
    {
        private photoshareEntities db = new photoshareEntities();


        /// <summary>
        /// Displays upload view
        /// </summary>
        /// <returns></returns>
        public ViewResult Upload()
        {
            //SELECT category_id,category_name from category;
            ViewBag.photo_category = new SelectList(db.categories, "category_id", "category_name", 1);
            return View();
        }

        /// <summary>
        /// handles photo upload 
        /// </summary>
        /// <param name="photo">The photo which is to be uploaded</param>
        /// <returns>returns view</returns>
        [HttpPost]
        public ActionResult Upload(photo photo)
        {
            if (ModelState.IsValid)
            {
                //only members can upload so check if user logged in else redirect to login page
                var loggedUser = GetLoggedUser();
                if (loggedUser == null)
                {
                    return RedirectToAction("LogOn", "Account");
                }

                //get the uploaded file
                HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                
                //check if the length of file > 0 i.e. its not a empty file
                if (file.ContentLength > 0)
                {
                    
                    var fileName = Path.GetFileNameWithoutExtension(file.FileName); //just filename
                    var fileExt = Path.GetExtension(file.FileName); // file extension
                    
                    var destinationDirectory = Path.Combine(Server.MapPath("~/Images/Uploads/"), loggedUser.id.ToString()); //where the image is going to be uploaded
                    var newFileTemp = loggedUser.id.ToString() + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff"); // filename format 
                    var newFileName = newFileTemp + "_L" + fileExt; //append the size L(large);M(Medium);S(Small) to the filename
                    var path = Path.Combine(destinationDirectory, newFileName);
                    try
                    {
                        //start transaction
                        using (TransactionScope scope = new TransactionScope())
                        {
                            //if the directory does not exist create it  
                            if (!Directory.Exists(destinationDirectory))
                            {
                                Directory.CreateDirectory(destinationDirectory);
                            }
                            // now save the file to the path
                            file.SaveAs(path);

                            //get the exif data of the image
                            //thanks to http://www.goheer.com for this simple utility
                            exif_data exifData = GetImageExifData(path);

                            //create medium thumbnail
                            var thumbMedium = newFileTemp + "_M" + fileExt;
                            CreateThumbnail(path, ImageSize.Medium, Path.Combine(destinationDirectory, thumbMedium));
                            
                            //create small thumbnail
                            var thumbSmall = newFileTemp + "_S" + fileExt;
                            CreateThumbnail(path, ImageSize.Small, Path.Combine(destinationDirectory, thumbSmall));

                            //save this photo to the data
                            /*
                             *INSERT INTO `photoshare`.`photos`(`name`,`description`,`uploaded_date`,`user_id`,`photo_url_o`,`photo_url_m`,`photo_url_s`,`photo_category`,`tags`,`views_count`,`likes_count`)
                                VALUES(?,?,?,?,?,?,?,?,?,?,?);
                             */
                            photo.photo_url_o = Url.Content("~/Images/Uploads/" + loggedUser.id.ToString() + "/" + newFileName);
                            photo.photo_url_m = Url.Content("~/Images/Uploads/" + loggedUser.id.ToString() + "/" + thumbMedium);
                            photo.photo_url_s = Url.Content("~/Images/Uploads/" + loggedUser.id.ToString() + "/" + thumbSmall);
                            photo.user_id = loggedUser.id;
                            photo.views_count = 0;
                            photo.likes_count = 0;
                            photo.popularity = 0;
                            photo.comments_count = 0;
                            photo.favs_count = 0;
                            db.photos.Add(photo);
                            db.SaveChanges();

                            //save to exif_data
                            /**
                             * INSERT INTO `photoshare`.`exif_data`(`photo_id`,`camera`,`aperture`,`shutter_speed`,`iso`,`date_taken`,`focal_length`)VALUES(?,?,?,?,?,?,?);
                             */
                                exifData.photo = photo;
                                db.exif_data.Add(exifData);
                                db.SaveChanges();

                            //everything went well complete the transaction
                            scope.Complete();
                        }
                        return RedirectToAction("Index", "User");
                    }
                    catch
                    {
                        //something bad has heppened. delete the original file if it was saved
                        FileInfo _file = new FileInfo(path);
                        if (_file.Exists)
                        {
                            _file.Delete();
                        }
                    }

                }
                else
                {
                    ModelState.AddModelError("", "Please select a valid file");
                }
            }

            ViewBag.photo_category = new SelectList(db.categories, "category_id", "category_name", photo.photo_category);
            return View(photo);
        }

        /// <summary>
        /// Reads the exif data of the image
        /// </summary>
        /// <param name="file">The image file</param>
        /// <returns>exif_data object</returns>
        private exif_data GetImageExifData(string file)
        {
            Goheer.EXIF.EXIFextractor exif = new Goheer.EXIF.EXIFextractor(file, "", "");
            exif_data exifData = new exif_data();
            try
            {  

                foreach (System.Web.UI.Pair s in exif)
                {
                    switch (s.First.ToString().ToLower())
                    {
                        case "aperture":
                            exifData.aperture = s.Second.ToString();
                            break;
                        case "f-number":
                            exifData.aperture = s.Second.ToString();
                            break;
                        case "shutter speed":
                            exifData.shutter_speed = s.Second.ToString();
                            break;
                        case "equip model":
                            exifData.camera = s.Second.ToString();
                            break;
                        case "iso speed":
                            exifData.iso = s.Second.ToString();
                            break;
                        case "date time":
                            exifData.date_taken = s.Second.ToString();
                            break;
                        case "focallength":
                            exifData.focal_length = s.Second.ToString();
                            break;
                        default:
                            break;
                    }
                }
                
            }
            catch
            {
            }
            return exifData;
        }

        
        //
        // GET: /Photo/
        //20 items at a time


        /// <summary>
        /// Gets the photos by votes count
        /// </summary>
        /// <param name="category">filter by category</param>
        /// <param name="page">pagenumber</param>
        /// <returns></returns>
        public ViewResult Index(string category = "All Categories", int page = 1)
        {
            if (string.IsNullOrEmpty(category))
                category = "All Categories";
            ViewBag.Category = category;
            //SELECT * FROM category
            ViewBag.Categories = new SelectList(db.categories, "category_name", "category_name", "All Categories");

            if (category.Equals("All Categories") || string.IsNullOrEmpty(category))
            {
                //SELECT * FROM photos order by likes_count,views_count DESC LIMIT page,pageSize
                var photos = db.photos.OrderByDescending(p => p.popularity).ThenByDescending(p=>p.uploaded_date);
                var paginatedPhotos = photos.ToPagedList(page, pageSize);
                return View(paginatedPhotos);
            }
            else
            {
                //SELECT * FROM photos WHERE category_id=category order by likes_count,views_count DESC LIMIT page,pageSize
                var photos = db.photos.Where(p => p.category.category_name == category).OrderByDescending(p => p.popularity).ThenByDescending(p => p.uploaded_date);
                var paginatedPhotos = photos.ToPagedList(page, pageSize);
                return View(paginatedPhotos);
            }
        }

        /// <summary>
        /// Gets the most recent photos
        /// </summary>
        /// <param name="category">filter by category</param>
        /// <param name="page">pagenumber</param>
        /// <returns></returns>
        public ActionResult Recent(string category = "All Categories", int page = 1)
        {
            if (string.IsNullOrEmpty(category))
                category = "All Categories";
            ViewBag.Category = category;
            ViewBag.Categories = new SelectList(db.categories, "category_name", "category_name", "All Categories");

            if (category.Equals("All Categories") || string.IsNullOrEmpty(category))
            {
                //SELECT * FROM photos order by uploaded_date DESC LIMIT page,pageSize
                var photos = db.photos.OrderByDescending(p => p.uploaded_date);
                var paginatedPhotos = photos.ToPagedList(page, pageSize);
                return View(paginatedPhotos);
            }
            else
            {
                //SELECT * FROM photos WHERE category_id=category order by uploaded_date DESC LIMIT page,pageSize
                var photos = db.photos.Where(p => p.category.category_name == category).OrderByDescending(p => p.uploaded_date);
                var paginatedPhotos = photos.ToPagedList(page, pageSize);
                return View(paginatedPhotos);
            }
        }

        /// <summary>
        /// Gets the most popular photos from the people your are following
        /// </summary>
        /// <param name="category">filter by category</param>
        /// <param name="page">pagenumber</param>
        /// <returns></returns>
        public ActionResult Following(string category = "All Categories", int page = 1)
        {
            var user = GetLoggedUser();
            if(user == null)
            {
                return Redirect("~/Account/LogOn");
            }
            if (string.IsNullOrEmpty(category))
                category = "All Categories";
            ViewBag.Category = category;
            ViewBag.Categories = new SelectList(db.categories, "category_name", "category_name", "All Categories");
            var _followers = db.followers.Where(u=>u.follower_who == user.id).Select(f=>f.follower_whom).ToArray();
            if(_followers.Count() >= 0 ) {
            }
            if (category.Equals("All Categories") || string.IsNullOrEmpty(category))
            {
                var followerPhotos = (from p in db.photos
                                      where _followers.Contains(p.user_id)
                                      select p).OrderByDescending(p => p.popularity).ThenByDescending(p => p.uploaded_date);

                var paginatedPhotos = followerPhotos.ToPagedList(page, pageSize);
                return View(paginatedPhotos);
            }
            else
            {                
                var followerPhotos = (from p in db.photos
                                      where _followers.Contains(p.user_id) && p.category.category_name == category
                                      select p).OrderByDescending(p => p.popularity).ThenByDescending(p => p.uploaded_date);

                var paginatedPhotos = followerPhotos.ToPagedList(page, pageSize);
                return View(paginatedPhotos);
            }
        }


        //
        // GET: /Photo/Details/5
        public ViewResult Details(int id)
        {
            //get the exif_data of the image
            ViewBag.EXIF = db.exif_data.Where(e => e.photo_id == id).FirstOrDefault();
            
            var loggedUser = GetLoggedUser();
            ViewBag.LoggedUser = loggedUser;

            photo _photo = db.photos.Find(id);
            ViewBag.IsFollowing = false;
            if (loggedUser != null) { 
                //check if the current logged in user is following the uploader of this image
                var isFollowing = (from f in db.followers
                                   join u in db.users on f.follower_who equals u.id
                                   where f.follower_whom == _photo.user_id && f.follower_who == loggedUser.id                                   
                                   select f).SingleOrDefault();
                if (isFollowing != null) {
                    ViewBag.IsFollowing = true;
                }
            }

            //SELECT * FROM photos where id = ?
            

            //increase the view count;
            //UPDATE photos SET views_count = views_count + 1 WHERE id= ?
            _photo.views_count = (_photo.views_count.HasValue) ? _photo.views_count.Value + 1 : 1;
            db.SaveChanges();
            return View(_photo);
        }


        //Add the photo to the user favorites list
        public ActionResult Fav(int id)
        {
            //check if the user is logged in
            var loggedUser = GetLoggedUser();
            if (loggedUser == null)
            {
                return RedirectToAction("LogOn", "Account");
            }

            string msg = string.Empty;


            //user cant favorite their own photo
            var photo = db.photos.Find(id);
            if (photo.user_id == loggedUser.id)
            {
                msg = "You can't favorite your own photo";
                ViewBag.Msg = msg;
                return View();
            }

            //check if already favorited
            var isFaved = db.favorites.Where(p => p.photo_id == id).Where(u => u.user_id == loggedUser.id).FirstOrDefault();

            //if not, then add to favorites
            if (isFaved == null)
            {
                db.favorites.Add(new favorite
                {
                    photo_id = id,
                    user_id = loggedUser.id,
                    fav_datetime = DateTime.Now
                });
                db.SaveChanges();
                //msg = "Successfully added this photo to your favorites";
                msg = "SUCCESS";
            }
            else
            {
                msg = "You have already added this photo to your favorites";
            }
            ViewBag.Msg = msg;
            return View();

        }

        public ActionResult Like(int id)
        {
            var loggedUser = GetLoggedUser();
            if (loggedUser == null)
            {
                return RedirectToAction("LogOn", "Account");
            }

            //user cant like their own photo
            var photo = db.photos.Find(id);
            if (photo.user_id == loggedUser.id)
            {                
                ViewBag.Msg = "You can't like your own photo";
                return View();
            }


            //check if already liked
            var isLiked = db.likes.Where(p => p.photo_id == id).Where(u => u.user_id == loggedUser.id).FirstOrDefault();

            //if not, then add to favorites table
            if (isLiked == null)
            {
                db.likes.Add(new like
                {
                    photo_id = id,
                    user_id = loggedUser.id,
                    like_datetime = DateTime.Now
                });
                db.SaveChanges();
                ViewBag.Msg = "SUCCESS";
            }
            else
            {
                ViewBag.Msg = "Sorry your vote failed";
            }
            return View();

        }

        public ActionResult Comment()
        {
            return View();
        }


        /// <summary>
        /// handles comment post
        /// </summary>
        /// <param name="coll"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Comment(FormCollection coll)
        {
            comment cmt = null;
            try
            {  
                //we need to add entries to comments and photo_comments table
                // so lets start transaction
                using (TransactionScope scope = new TransactionScope())
                {
                    //first add to comment
                    //INSERT INTO comment (comment_datetime, comment_text, user_id) VALUES (?,?,?)
                    cmt = new comment
                    {
                        comment_datetime = DateTime.Now,
                        comment_text = coll["comment_text"],
                        user_id = Int32.Parse(coll["user_id"])
                    };
                    db.comments.Add(cmt);
                    db.SaveChanges();

                    //now take the reference of comment and add to photo_comment
                    photo_comments phComment = new photo_comments
                    {
                        comment = cmt,
                        photo_id = Int32.Parse(coll["photo_id"])
                    };

                    db.photo_comments.Add(phComment);
                    db.SaveChanges();

                    ViewBag.User = db.users.Include(m => m.membership).Where(u => u.id == cmt.user_id).SingleOrDefault();

                    scope.Complete();

                    return View(cmt);
                }
            }
            catch
            {
                return View(cmt);
            }
        }

        //
        // GET: /Photo/Edit/5

        public ActionResult Edit(int id)
        {
            photo photo = db.photos.Find(id);
            ViewBag.photo_category = new SelectList(db.categories, "category_id", "category_name", photo.photo_category);
            ViewBag.exif_data = new SelectList(db.exif_data, "id", "manufacturer", photo.exif_data);
            ViewBag.user_id = new SelectList(db.users, "id", "first_name", photo.user_id);
            return View(photo);
        }

        //
        // POST: /Photo/Edit/5

        [HttpPost]
        public ActionResult Edit(photo photo)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.Entry(photo).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Details", "Photo", new { id = photo.id });
                }
            }
            catch (DbEntityValidationException dbEx)
            {
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        Trace.TraceInformation("Property: {0} Error: {1}", validationError.PropertyName, validationError.ErrorMessage);
                    }
                }
            }
            ViewBag.photo_category = new SelectList(db.categories, "category_id", "category_name", photo.photo_category);
            ViewBag.exif_data = new SelectList(db.exif_data, "id", "manufacturer", photo.exif_data);
            ViewBag.user_id = new SelectList(db.users, "id", "first_name", photo.user_id);
            return View(photo);
        }

        //
        // GET: /Photo/Delete/5

        public ActionResult Delete(int id)
        {
            photo photo = db.photos.Find(id);
            return View(photo);
        }

        //
        // POST: /Photo/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            var loggedUser = GetLoggedUser();
            if (loggedUser == null)
            {
                return RedirectToAction("LogOn", "Account");
            }
            photo photo = db.photos.Find(id);
            if (photo == null) 
            {
                return RedirectToAction("Index");
            }
            using (TransactionScope scope = new TransactionScope())
            {
                MySqlParameter p =  new MySqlParameter("photoId",id);
                db.Database.ExecuteSqlCommand("CALL spPhotoDelete(@photoId)",p);

                // now delete images from file
                FileInfo _fileO = new FileInfo(Server.MapPath(photo.photo_url_o));
                if (_fileO.Exists)
                    _fileO.Delete();
                FileInfo _fileM = new FileInfo(Server.MapPath(photo.photo_url_m));
                if (_fileM.Exists)
                    _fileM.Delete();
                FileInfo _fileS = new FileInfo(Server.MapPath(photo.photo_url_s));
                if (_fileS.Exists)
                    _fileS.Delete();

                
                scope.Complete();
            }
            return RedirectToAction("Index","User");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}