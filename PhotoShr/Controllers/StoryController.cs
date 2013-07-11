using PhotoShr.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Transactions;
using PagedList;

namespace PhotoShr.Controllers
{
    public class StoryController : BaseController
    {

        private photoshareEntities db = new photoshareEntities();

        // GET: /Story/        
        public ActionResult Index(int? page)
        {
            var allStories = from c in db.collections
                           join s in db.stories on c.collection_id equals s.collection_id
                           orderby c.created_date
                           select s;

            var paginatedStories = allStories.ToPagedList(page ?? 1, pageSize);
            return View(paginatedStories);
        }

        //
        // GET: /Story/Details/5

        public ActionResult Details(int id)
        {
            var loggedUser = GetLoggedUser();
            ViewBag.LoggedUser = loggedUser;

            var storyDetails = db.stories.Find(id);
            return View(storyDetails);
        }

        [HttpPost]
        public ActionResult Comment(FormCollection coll)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                comment cmt = new comment
                {
                    comment_datetime = DateTime.Now,
                    comment_text = coll["comment_text"],
                    user_id = Int32.Parse(coll["user_id"])
                };
                db.comments.Add(cmt);
                db.SaveChanges();

                story_comments phComment = new story_comments
                {
                    comment = cmt,
                    story_id = Int32.Parse(coll["story_id"])
                };

                db.story_comments.Add(phComment);
                db.SaveChanges();

                ViewBag.User = db.users.Where(u => u.id == cmt.user_id).SingleOrDefault();
                scope.Complete();
                return View(cmt);
            }
        }


        //
        // GET: /Story/Create

        public ActionResult Create()
        {

            var _user = GetLoggedUser();
            if (_user == null)
            {
                return Redirect("~/Account/LogOn/");
            }
            ViewBag.User = _user;


            var _userPhotos = from p in db.photos
                              where p.user_id == _user.id
                              select p;

            ViewBag.UserPhotos = _userPhotos.ToList();
            return View();
        }

        //
        // POST: /Story/Create

        [HttpPost]
        public ActionResult Create(FormCollection sForm)
        {
            var _user = GetLoggedUser();
            if (_user == null)
            {
                return Redirect("~/Account/LogOn/");
            }
            ViewBag.User = _user;

            var _userPhotos = from p in db.photos
                              where p.user_id == _user.id
                              select p;

            ViewBag.UserPhotos = _userPhotos.ToList();

            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    //create a record in collection
                    //create a record in story
                    //create a record in collection_photos
                    collection storyCollection = new collection
                    {
                        collection_name = sForm["title"],
                        created_by = _user.id,
                        created_date = DateTime.Now
                    };
                    db.collections.Add(storyCollection);
                    db.SaveChanges();

                    story currentStory = new story { 
                        description = sForm["description"],
                        tags = sForm["tags"]
                    };
                    currentStory.collection = storyCollection;
                    db.stories.Add(currentStory);
                    db.SaveChanges();

                    if (sForm["photos"] != null) {
                        string[] AllPhotos = sForm["photos"].ToString().Split(',');
                        foreach (var p in AllPhotos) {
                            collection_photos cp = new collection_photos { 
                                collection = storyCollection,
                                photo_id = Int32.Parse(p)
                            
                            };
                            db.collection_photos.Add(cp);
                            db.SaveChanges();
                        }
                    }
                    scope.Complete();
                    return Redirect(string.Format("/User/{0}/Stories", Session["LoggedInUser"].ToString()));
                }
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Story/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Story/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Story/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Story/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
