using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class UserPhoto
    {
        public UserPhoto()
        {
            User = new User();
        }
        public virtual int PhotoID { get; set; }
        public virtual User User { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as UserPhoto;
            if (t == null)
                return false;
            if (PhotoID == t.PhotoID && User == t.User)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (PhotoID + "|" + User.UserID).GetHashCode();
        }
    }
}
