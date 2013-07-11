//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PhotoShr.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class user
    {
        public user()
        {
            this.collections = new HashSet<collection>();
            this.comments = new HashSet<comment>();
            this.followers = new HashSet<follower>();
            this.followers1 = new HashSet<follower>();
            this.group_members = new HashSet<group_members>();
            this.photos = new HashSet<photo>();
            this.user_activity = new HashSet<user_activity>();
            this.favorites = new HashSet<favorite>();
            this.likes = new HashSet<like>();
        }
    
        public int id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string about { get; set; }
        public string gender { get; set; }
        public string city { get; set; }
        public string country { get; set; }
        public string profile_photo { get; set; }
        public int membership_id { get; set; }
    
        public virtual ICollection<collection> collections { get; set; }
        public virtual ICollection<comment> comments { get; set; }
        public virtual ICollection<follower> followers { get; set; }
        public virtual ICollection<follower> followers1 { get; set; }
        public virtual ICollection<group_members> group_members { get; set; }
        public virtual membership membership { get; set; }
        public virtual ICollection<photo> photos { get; set; }
        public virtual ICollection<user_activity> user_activity { get; set; }
        public virtual ICollection<favorite> favorites { get; set; }
        public virtual ICollection<like> likes { get; set; }
    }
}
