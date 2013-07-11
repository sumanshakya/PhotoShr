using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhotoShr.Controllers
{
    public class SearchController : BaseController
    {


        // GET: /Search/
        PhotoShr.Models.photoshareEntities db = new Models.photoshareEntities();

        /// <summary>
        /// Does a full-text search against tags,name and description
        /// </summary>
        /// <param name="q"></param>
        /// <param name="page"></param>
        /// <returns></returns>
        public ActionResult Index(string q, int page = 1)
        {
            ViewBag.SearchQuery = q;

            List<Models.photo> results = null;
            if (!string.IsNullOrEmpty(q))
            {
                string sql = "SELECT p.* FROM photos as p " +
                            "INNER JOIN users as u ON u.id = p.user_id " +
                            "INNER JOIN membership as m ON m.membership_id = u.membership_id " +
                            "LEFT JOIN exif_data as ed ON p.id = ed.photo_id " +
                            "WHERE MATCH (p.tags) AGAINST ('" + q + "' IN  NATURAL LANGUAGE MODE)" +
                            "OR MATCH(p.name) AGAINST ('" + q + "' IN NATURAL LANGUAGE MODE) " +
                            "OR MATCH(p.description) AGAINST ('" + q + "' IN NATURAL LANGUAGE MODE) " +
                            "OR MATCH(ed.camera) AGAINST ('" + q + "' IN NATURAL LANGUAGE MODE) " +
                            "OR MATCH(u.first_name) AGAINST ('" + q + "' IN NATURAL LANGUAGE MODE) " +
                            "OR MATCH(u.last_name) AGAINST ('" + q + "' IN NATURAL LANGUAGE MODE) " +
                            "OR MATCH(m.username) AGAINST ('" + q + "' IN NATURAL LANGUAGE MODE)";

                results = db.photos.SqlQuery(sql).ToList();
            }

            return View(results);
        }
    }
}
