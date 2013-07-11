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
    
    public partial class photo
    {
        public photo()
        {
            this.exif_data = new HashSet<exif_data>();
            this.photo_comments = new HashSet<photo_comments>();
            this.user_activity = new HashSet<user_activity>();
            this.favorites = new HashSet<favorite>();
            this.collection_photos = new HashSet<collection_photos>();
            this.likes = new HashSet<like>();
        }
    
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public System.DateTime uploaded_date { get; set; }
        public int user_id { get; set; }
        public string photo_url_o { get; set; }
        public string photo_url_m { get; set; }
        public string photo_url_s { get; set; }
        public int photo_category { get; set; }
        public string tags { get; set; }
        public Nullable<int> views_count { get; set; }
        public Nullable<int> likes_count { get; set; }
        public Nullable<int> comments_count { get; set; }
        public Nullable<int> favs_count { get; set; }
        public Nullable<float> popularity { get; set; }
    
        public virtual category category { get; set; }
        public virtual ICollection<exif_data> exif_data { get; set; }
        public virtual ICollection<photo_comments> photo_comments { get; set; }
        public virtual ICollection<user_activity> user_activity { get; set; }
        public virtual user user { get; set; }
        public virtual ICollection<favorite> favorites { get; set; }
        public virtual ICollection<collection_photos> collection_photos { get; set; }
        public virtual ICollection<like> likes { get; set; }
    }
}
