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
    public class GroupController : BaseController
    {
        private photoshareEntities db = new photoshareEntities();

        //
        // GET: /Group/

        public ViewResult Index()
        {
            var groups = db.groups.Include(g => g.collection);
            return View(groups.ToList());
        }

        /// <summary>
        /// Adds Photos to a group
        /// </summary>
        /// <param name="coll"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult PhotoAdd(FormCollection coll)
        {
            string grpId = coll["group_id"].ToString();
            using (TransactionScope scope = new TransactionScope())
            {
                string[] selectedPhotos = coll["photos"].ToString().Split(',');
                if (selectedPhotos.Count() > 0)
                {
                    foreach (var sp in selectedPhotos)
                    {
                        collection_photos cp = new collection_photos
                        {
                            collection_id = Int32.Parse(coll["collection_id"]),
                            photo_id = Int32.Parse(sp)
                        };
                        db.collection_photos.Add(cp);
                        db.SaveChanges();
                    }
                }
                scope.Complete();
            }
            return Redirect(string.Format("/Group/Details/{0}",grpId));
        }
        //
        // GET: /Group/Details/5

        public ActionResult Details(int id, string view)
        {
            var group = db.groups.Find(id);
            ViewBag.Group = group;
            var _user = GetLoggedUser();
            ViewBag.IsMember = false;
            //check if user is a memebr of this group
            if (_user != null)
            {
                var check = (from gm in db.group_members
                             where gm.user_id == _user.id
                             && gm.group_id == id
                             select gm).FirstOrDefault();
                if (check != null)
                {
                    ViewBag.IsMember = true;
                }
            }

            if (string.IsNullOrEmpty(view))
                view = "photos";


            switch (view)
            {
                case "members":
                    var grp_mem = db.group_members.Where(gm => gm.group_id == id);
                    return View("group_members", grp_mem.ToList());
                    
                case "about":
                    return View("group_about", group);
                    
                case "add":
                    if (_user == null)
                    {
                        return RedirectToAction("LogOn", "Account");
                    }
                    var _userPhotos = from p in db.photos
                                      where p.user_id == _user.id
                                      select p;

                    ViewBag.UserPhotos = _userPhotos.ToList();
                    return View("group_add");
                case "join":
                    if (_user == null)
                    {
                        return RedirectToAction("LogOn", "Account");
                    }
                    db.group_members.Add(new group_members
                    {
                        group_id = id,
                        joined_date = DateTime.Now,
                        user_id = _user.id
                    });
                    db.SaveChanges();
                    return RedirectToAction("Details", "Group", new { @id = id });
                    
                case "photos":
                default:
                    var grp_photos = from c in db.collections
                                     join cp in db.collection_photos on c.collection_id equals cp.collection_id
                                     join g in db.groups on c.collection_id equals g.collection_id
                                     where g.id == id
                                     select cp;

                    return View(grp_photos.ToList());
                    
            }
        }

        //
        // GET: /Group/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Group/Create

        [HttpPost]
        public ActionResult Create(group group)
        {
            var _user = GetLoggedUser();
            if (_user == null)
            {
                return RedirectToAction("LogOn", "Account");
            }
            if (ModelState.IsValid)
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    collection coll = new collection
                    {
                        collection_name = group.collection.collection_name,
                        created_by = _user.id,
                        created_date = DateTime.Now
                    };
                    db.collections.Add(coll);
                    db.SaveChanges();

                    group newgroup = new Models.group
                    {
                        collection = coll,
                        description = group.description
                    };
                    db.groups.Add(newgroup);
                    db.SaveChanges();

                    //add the user who created the group as one of the group member
                    group_members gm = new group_members
                    {
                        group = newgroup,
                        user_id = _user.id
                    };
                    db.group_members.Add(gm);
                    db.SaveChanges();

                    scope.Complete();
                }
                return RedirectToAction("Index");
            }
            ModelState.AddModelError("", "Could not create new group");
            return View(group);
        }

        //
        // GET: /Group/Edit/5

        public ActionResult Edit(int id)
        {
            group group = db.groups.Find(id);
            ViewBag.collection_id = new SelectList(db.collections, "collection_id", "collection_name", group.collection_id);
            return View(group);
        }

        //
        // POST: /Group/Edit/5

        [HttpPost]
        public ActionResult Edit(group group)
        {
            if (ModelState.IsValid)
            {
                db.Entry(group).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.collection_id = new SelectList(db.collections, "collection_id", "collection_name", group.collection_id);
            return View(group);
        }

        //
        // GET: /Group/Delete/5

        public ActionResult Delete(int id)
        {
            group group = db.groups.Find(id);
            return View(group);
        }

        //
        // POST: /Group/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            group group = db.groups.Find(id);
            db.groups.Remove(group);
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