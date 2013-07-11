using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace PhotoShr
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //           routes.MapRoute(
            //    "Recents",                               // Route name
            //    "Recent/Page/{page}",                           // URL with params
            //    new { controller = "Photo", action = "Recent" } // Param defaults
            //);

            //           routes.MapRoute(
            //               "StoriesWithoutPage",                               // Route name
            //               "stories",                           // URL with params
            //               new { controller = "Story", action = "Index" } // Param defaults
            //           );

            //           routes.MapRoute(
            //               "StoriesWithPage",                               // Route name
            //               "stories/page/{page}",                           // URL with params
            //               new { controller = "Story", action = "Index" } // Param defaults
            //           );

            //           routes.MapRoute(
            //               "PhotosWithoutPage",                               // Route name
            //               "photos/popular/{category}",                           // URL with params
            //               new { controller = "Photo", action = "Index", category = UrlParameter.Optional } // Param defaults
            //           );

            //           routes.MapRoute(
            //              "comment", // Route name
            //              "Photo/Comment", // URL with parameters
            //              new { controller = "Photo", action = "Comment" } // Parameter defaults
            //          );

            //           routes.MapRoute(
            //               "PhotoUpload", // Route name
            //               "photo/upload", // URL with parameters
            //               new { controller = "Photo", action = "Upload" } // Parameter defaults
            //           );

            //           routes.MapRoute(
            //               "Photos",                               // Route name
            //               "photos/popular/{category}/page/{page}",                           // URL with params
            //               new { controller = "Photo", action = "Index", category = UrlParameter.Optional } // Param defaults
            //           );
            //           routes.MapRoute(
            //             "PhotoDetails",                               // Route name
            //             "photo/{id}",                           // URL with params
            //             new { controller = "Photo", action = "Details", id = UrlParameter.Optional } // Param defaults
            //         );
           // routes.MapRoute(
           //    "Default4", // Route name
           //    "{controller}/Details/{groupId}/{view}", // URL with parameters
           //    new { controller = "Group", action = "Details", groupId = "", view = UrlParameter.Optional } // Parameter defaults
           //);
            routes.MapRoute(
              "Set", // Route name
              "Set/Index/{id}/", // URL with parameters
              new { controller = "Set", action = "Index", id = "" } // Parameter defaults
          );

            routes.MapRoute(
             "UserFollow", // Route name
             "User/{username}/Follow/{id}", // URL with parameters
             new { controller = "User", action = "Follow", username = "", id = "" } // Parameter defaults
         );

            routes.MapRoute(
              "UserPhotos", // Route name
              "User/{username}/{action}/", // URL with parameters
              new { controller = "User", action = "Index", username = "" } // Parameter defaults
          );


            routes.MapRoute(
              "Following", // Route name
              "{controller}/Following/{category}/{page}", // URL with parameters
              new { controller = "Photo", action = "Following", category = "", page = "" } // Parameter defaults
          );


            routes.MapRoute(
              "Recent", // Route name
              "{controller}/Recent/{category}/{page}", // URL with parameters
              new { controller = "Photo", action = "Recent", category = "", page = "" } // Parameter defaults
          );

            routes.MapRoute(
               "Default3", // Route name
               "{controller}/Index/{category}/{page}", // URL with parameters
               new { controller = "Photo", action = "Index", category = "", page = "" } // Parameter defaults
           );

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            // Use LocalDB for Entity Framework by default
            //Database.DefaultConnectionFactory = new SqlConnectionFactory(@"Data Source=(localdb)\v11.0; Integrated Security=True; MultipleActiveResultSets=True");

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }
    }
}