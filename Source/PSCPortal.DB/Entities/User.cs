using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class User
    {
        public User()
        {
            UserPhotoList = new List<UserPhoto>();
        }
        public virtual int UserID { get; set; }
        public virtual string CardNumber { get; set; }
        public virtual string FullName { get; set; }
        public virtual int Gender { get; set; }
        public virtual string DateOfBirth { get; set; }
        public virtual string PlaceOfBirth { get; set; }
        public virtual string ContactPhone { get; set; }
        public virtual string ContactEmail { get; set; }
        public virtual string ContactAddress { get; set; }
        public virtual string BankAccount { get; set; }
        public virtual int UserStatus { get; set; }
        public virtual string Pw { get; set; }
        public virtual DateTime WorkingFromDate { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual IList<UserPhoto> UserPhotoList { get; set; }
    }
}
