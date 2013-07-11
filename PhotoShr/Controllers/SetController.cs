using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhotoShr.Models;
using System.Transactions;

namespace PhotoShr.Controllers
{
    public class SetController : BaseController
    {
        private photoshareEntities db = new photoshareEntities();

        //
        // GET: /Set/

        public ViewResult Index(int id)
        {
            var _set = db.sets.Include(s => s.collection).Where(s=>s.set_id == id).SingleOrDefault();
            return View(_set);
        }

        //
        // GET: /Set/Details/5

        public ViewResult Details(int id)
        {
            set set = db.sets.Find(id);
            return View(set);
        }

        //
        // GET: /Set/Create

        public ActionResult Create()
        {
            var _user = this.GetLoggedUser();
            if (_user == null)
            {
                return RedirectToAction("LogOn", "Account");
            }
            var _userPhotos = from p in db.photos
                              where p.user_id == _user.id
                              select p;

            ViewBag.UserPhotos = _userPhotos.ToList();
            return View();
        }

        //
        // POST: /Set/Create

        [HttpPost]        
        public ActionResult Create(FormCollection sForm)
        {
            var _user = GetLoggedUser();
            if (_user == null)
            {
                return Redirect("~/Account/LogOn/");
            }
            ViewBag.User = _user;
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    //create a record in collection
                    //create a record in set
                    //create a record in collection_photos
                    collection _setCollection = new collection
                    {
                        collection_name = sForm["title"],
                        created_by = _user.id,
                        created_date = DateTime.Now
                    };
                    db.collections.Add(_setCollection);
                    db.SaveChanges();

                    set _set = new set();
                    _set.collection = _setCollection;
                    db.sets.Add(_set);
                    db.SaveChanges();

                    if (sForm["photos"] != null)
                    {
                        string[] AllPhotos = sForm["photos"].ToString().Split(',');
                        foreach (var p in AllPhotos)
                        {
                            collection_photos cp = new collection_photos
                            {
                                collection = _setCollection,
                                photo_id = Int32.Parse(p)
                            };
                            db.collection_photos.Add(cp);
                            db.SaveChanges();
                        }
                    }
                    scope.Complete();
                }
                var _userPhotos = from p in db.photos
                                  where p.user_id == _user.id
                                  select p;

                ViewBag.UserPhotos = _userPhotos.ToList();
                // TODO: Add insert logic here

                return Redirect(string.Format("/User/{0}/Sets",Session["LoggedInUser"].ToString()));
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Set/Edit/5

        public ActionResult Edit(int id)
        {
            set set = db.sets.Find(id);
            ViewBag.collection_id = new SelectList(db.collections, "collection_id", "collection_name", set.collection_id);
            return View(set);
        }

        //
        // POST: /Set/Edit/5

        [HttpPost]
        public ActionResult Edit(set set)
        {
            if (ModelState.IsValid)
            {
                db.Entry(set).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.collection_id = new SelectList(db.collections, "collection_id", "collection_name", set.collection_id);
            return View(set);
        }

        //
        // GET: /Set/Delete/5

        public ActionResult Delete(int id)
        {
            set set = db.sets.Find(id);
            return View(set);
        }

        //
        // POST: /Set/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            set set = db.sets.Find(id);
            db.sets.Remove(set);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}