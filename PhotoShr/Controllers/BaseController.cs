using PhotoShr.Models;
using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhotoShr.Controllers
{
    public class BaseController : Controller
    {
        //
        // GET: /Base/
        public const int pageSize = 20;


        protected user GetUser(string username)
        {
            user _user = null;
            using (photoshareEntities db = new photoshareEntities())
            {                
                var _u = (from u in db.users
                                    join m in db.memberships on u.membership_id equals m.membership_id
                                    where m.username == username
                                    select u).FirstOrDefault();
                _user = _u as user;
            }
            return _user;
        }

        /// <summary>
        /// Gets the current logged in user by checking session variables
        /// </summary>
        /// <returns>A currently logged in user </returns>
        protected user GetLoggedUser()
        {
            if (Session["LoggedInUser"] == null)
            {
                return null;
            }
            user _loggedInUser = null;
            using (photoshareEntities db = new photoshareEntities())
            {
                var username = Session["LoggedInUser"].ToString();
                var loggedInUser = (from u in db.users
                                 join m in db.memberships on u.membership_id equals m.membership_id
                                 where m.username == username
                                 select u).FirstOrDefault();
                _loggedInUser = loggedInUser as user;
            }

            return _loggedInUser;
            
        }

        /// <summary>
        /// Create thumbnail based on the input paramter sizes
        /// </summary>
        /// <param name="filename">the image file from which to create a thumbnail</param>
        /// <param name="desiredWidth">width of thumbnail</param>
        /// <param name="desiredHeight">height of thumbnail</param>
        /// <param name="outFilename">the name of the generated thumbnail</param>
        public static void CreateThumbnail(string filename, int desiredWidth, int desiredHeight, string outFilename)
        {
            using (System.Drawing.Image img = System.Drawing.Image.FromFile(filename))
            {
                float widthRatio = (float)img.Width / (float)desiredWidth;
                float heightRatio = (float)img.Height / (float)desiredHeight;
                // Resize to the greatest ratio
                float ratio = heightRatio > widthRatio ? heightRatio : widthRatio;
                int newWidth = Convert.ToInt32(Math.Floor((float)img.Width / ratio));
                int newHeight = Convert.ToInt32(Math.Floor((float)img.Height / ratio));
                using (System.Drawing.Image thumb = img.GetThumbnailImage(newWidth, newHeight, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailImageAbortCallback), IntPtr.Zero))
                {
                    thumb.Save(outFilename, System.Drawing.Imaging.ImageFormat.Jpeg);
                }
            }
        }

        /// <summary>
        /// Create thumbnail based on the size ration
        /// </summary>
        /// <param name="filename">the image file from which to create a thumbnail</param>
        /// <param name="imgSize">Can be original, medium,small. Original size is not cared for. For Medium, image size is divided by 2 and for Small, size is divided by 4</param>
        /// <param name="outFilename">the name of the generated thumbnail</param>
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
            }
        }

        public static bool ThumbnailImageAbortCallback()
        {
            return true;
        }

    }
}
