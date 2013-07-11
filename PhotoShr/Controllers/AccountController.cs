/*
 * Suman Shakya 
 * 
 * 
 *AccountController
 *Manages user login, logout and registration 
 *
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using PhotoShr.Models;
using System.Transactions;
using System.Data.SqlClient;
using System.Data;
using MySql.Data.MySqlClient;

namespace PhotoShr.Controllers
{
    public class AccountController : Controller
    {

        //
        // GET: /Account/LogOn
        private photoshareEntities db = new photoshareEntities();

        public ActionResult LogOn()
        {
            return View();
        }

        //
        // POST: /Account/LogOn

        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                using (photoshareEntities dbContext = new photoshareEntities())
                {
                    try
                    {
                        /*JUST TO SHOW I CAN WRITE SQL QUERIES AS WELL :) */

                        var @sqlAuthenticateUser = 
                            "SELECT m.* FROM membership as m INNER JOIN " +
                            "users AS u ON m.membership_id = u.membership_id " +
                            "WHERE m.username={0} AND m.password={1} LIMIT 0,1";
                        var isAuthenticUser = dbContext.memberships.
                            SqlQuery(sqlAuthenticateUser, 
                            model.UserName, model.Password).SingleOrDefault();

                        if (isAuthenticUser == null)
                        {
                            ModelState.AddModelError("", "The user name or password provided is incorrect.");
                        }
                        else
                        {
                            Session.Add("LoggedInUser", isAuthenticUser.username);

                            if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                                && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                            {
                                return Redirect(returnUrl);
                            }
                            else
                            {
                                return RedirectToAction("Index", "Photo");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ModelState.AddModelError("UNKNOWN_ERROR", ex.Message);
                    }
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/LogOff

        public ActionResult LogOff()
        {
            Session.Remove("LoggedInUser");
            Session.RemoveAll();
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/Register

        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register

        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    //start transaction block
                    using (TransactionScope scope = new TransactionScope())
                    {
                        /*
                         * check if username is already present 
                         * in the membership table
                         * SELECT membership_id FROM membership 
                         * WHERE username = "?" LIMIT 0,1
                         */

                        var isUsernameTaken = (from m in db.memberships
                                    where m.username == model.UserName
                                    select m.membership_id).SingleOrDefault();
                        if (isUsernameTaken > 1)
                        {
                            ModelState.AddModelError("", 
                                "Username is already taken. Please choose another");
                            return View(model);
                        }
                        else
                        {

                            /*
                             * CREATE a new record in member with user 
                             * provided username,password and email
                             * INSERT INTO membership 
                             * (username,password,email,is_approved) 
                             * VALUES (?,?,?,?)
                             * 
                             *  we are skipping email validation for 
                             *  the demo due lack of time :(  
                             *  no password hashing for the sake of simplity right now 
                             */
                            var newMember = new membership
                            {
                                username = model.UserName,
                                password = model.Password, 
                                email = model.Email,
                                is_approved = "Y", 
                                joined_date = DateTime.Now

                            };
                            db.memberships.Add(newMember);
                            db.SaveChanges();

                            /* NOW create a user record with the 
                             * membership_id of previous insert. INSERT DEFAULT DATA FOR NOW.                            
                             * INSERT INTO users (gender,membership_id) VALUES (?,?)
                             */
                            var newUser = new user
                            {
                                gender = Gender.Unspecified.ToString(),
                                membership = newMember
                            };
                            db.users.Add(newUser);
                            db.SaveChanges();

                            //everything is OK. Set the username in session 
                            Session.Add("LoggedInUser", model.UserName);
                            //transaction complete
                            scope.Complete();
                            return Redirect(string.Format("/User/{0}/Index", model.UserName));
                        }
                    }                    
                }
                catch (Exception ex)
                {
                    //exception occured. transaction scope is incomplete 
                    //so no need to rollback. display some generic error 
                    ModelState.AddModelError("", "Could not register");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ChangePassword

        //[Authorize]
        //public ActionResult ChangePassword()
        //{
        //    return View();
        //}
    }
}
