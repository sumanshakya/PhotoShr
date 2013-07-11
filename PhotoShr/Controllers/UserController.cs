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

namespace PhotoShr.Controllers
{
    public class UserController : BaseController
    {
        private photoshareEntities db = new photoshareEntities();

        //
        // GET: /User/

        public ActionResult ChangePassword()
        {
            var _user = GetLoggedUser();
            if (_user == null)
            {
                return Redirect("~/Account/LogOn/");
            }
            return View();
        }
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            var _user = GetLoggedUser();
            if (_user == null)
            {
                return Redirect("~/Account/LogOn/");
            }
            if (ModelState.IsValid)
            {
                try
                {
                    var _membership = db.memberships.Where(m => m.membership_id == _user.membership_id).Where(m => m.password == model.OldPassword).SingleOrDefault();
                    if (_membership != null)
                    {
                        db.Entry(_membership).State = EntityState.Modified;
                        _membership.password = model.NewPassword;
                        db.SaveChanges();
                        return RedirectToAction("ChangePassword");
                    }
                    else
                    {
                        ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                    }
                }
                catch (Exception)
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }


        public ActionResult Profile()
        {
            var _user = GetLoggedUser();
            if (_user == null)
            {
                return Redirect("~/Account/LogOn/");
            }
            var users = db.users.Include(u => u.membership).Where(u => u.id == _user.id).SingleOrDefault();
            return View(users);
        }

        [HttpPost]
        public ActionResult Profile(user profile)
        {
            var loggedUser = GetLoggedUser();
            if (loggedUser == null)
            {
                return RedirectToAction("LogOn", "Account");
            }
            if (ModelState.IsValid)
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    var mem = db.memberships.Where(m => m.membership_id == loggedUser.membership_id).SingleOrDefault();
                    mem.email = profile.membership.email;
                    db.SaveChanges();

                    db.Entry(profile).State = EntityState.Modified;
                    profile.membership = mem;

                    HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                    if (file.ContentLength > 0)
                    {
                        var fileName = Path.GetFileNameWithoutExtension(file.FileName);
                        var fileExt = Path.GetExtension(file.FileName);

                        var destinationDirectory = Server.MapPath("~/Images/Profile/");
                        var newFileName = profile.id + "_" + profile.last_name + fileExt;
                        var path = Path.Combine(destinationDirectory, newFileName);
                        try
                        {

                            if (!Directory.Exists(destinationDirectory))
                            {
                                Directory.CreateDirectory(destinationDirectory);
                            }

                            file.SaveAs(path);

                            var thumb = profile.id + "_" + profile.last_name + "_S" + fileExt;
                            CreateThumbnail(path, 100, 100, Path.Combine(destinationDirectory, thumb));

                            profile.profile_photo = Url.Content("~/Images/Profile/" + thumb);

                        }
                        catch
                        {
                            profile.profile_photo = "";
                        }
                        finally
                        {
                            FileInfo _file = new FileInfo(path);
                            if (_file.Exists)
                            {
                                _file.Delete();
                            }
                        }
                    }

                    db.SaveChanges();
                    scope.Complete();

                }
                return RedirectToAction("Index", "User");
            }

            string[] _g = new string[] { "Unspecified", "Male", "Female" };
            ViewBag.gender = new SelectList(_g);
            return View(profile);
        }


        public ActionResult Follow(string username, int id)
        {
            var _user = GetLoggedUser();
            if (_user == null)
            {
                return Redirect("~/Account/LogOn/");
            }

            var isFollowing = (from u in db.users
                               join f in db.followers on u.id equals f.follower_who
                               where f.follower_who == _user.id && f.follower_whom == id
                               select f).SingleOrDefault();
            if (isFollowing == null)
            {
                db.followers.Add(new follower
                {
                    follower_who = _user.id,
                    follower_whom = id
                });
                db.SaveChanges();
                ViewBag.Msg = "SUCCESS";
                return View();
            }
            else {
                ViewBag.Msg = "FAILED";
                return View();
            }

        }

        public ActionResult RecentActivity(string username) {
            var _user = GetUser(username);
            ViewBag.User = _user;
            ViewBag.Username = username;

            var activity = db.user_activity.Where(u => u.user_id == _user.id).OrderByDescending(a => a.activity_time);
            return View(activity.ToList());
        }

        public ActionResult Stories(string username)
        {

            var _user = GetUser(username);
            ViewBag.User = _user;
            ViewBag.Username = username;

            var userStories = from c in db.collections
                              join s in db.stories on c.collection_id equals s.collection_id
                              where c.created_by == _user.id
                              select s;

            //var users = db.users.Include(u => u.membership).Include(p => p.photos);
            return View(userStories.ToList());
        }

        public ActionResult Groups(string username)
        {
            var _user = GetUser(username);
            ViewBag.User = _user;
            ViewBag.Username = username;
            
            var userCreatedGroups = from c in db.collections
                             join g in db.groups on c.collection_id equals g.collection_id
                             where c.created_by == _user.id
                             select g;
            ViewBag.UserCreatedGroups = userCreatedGroups.ToList();


            var memberOfGroups = from c in db.collections
                               join g in db.groups on c.collection_id equals g.collection_id
                               join gm in db.group_members on g.id equals gm.group_id
                               where gm.user_id == _user.id
                               select g;

            return View(memberOfGroups.ToList());
        }

        public ActionResult Sets(string username)
        {
            var _user = GetUser(username);
            ViewBag.User = _user;
            ViewBag.Username = username;
            var userSets = from c in db.collections
                           join s in db.sets on c.collection_id equals s.collection_id
                           where c.created_by == _user.id
                           select s;
            return View(userSets.ToList());
        }

        public ActionResult Favorites(string username)
        {
            var _user = GetUser(username);
            ViewBag.User = _user;
            ViewBag.Username = username;
            var _userFavs = from p in db.photos
                            join f in db.favorites on p.id equals f.photo_id
                            where f.user_id == _user.id
                            select p;
            return View(_userFavs.ToList());
        }

        public ActionResult Index(string username)
        {
            if (string.IsNullOrEmpty(username))
                username = Session["LoggedInUser"].ToString();

            var _user = GetUser(username);
            ViewBag.User = _user;
            ViewBag.Username = username;
            var _userPhotos = db.photos.Where(p => p.user.id == _user.id);
            return View(_userPhotos.ToList());
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}