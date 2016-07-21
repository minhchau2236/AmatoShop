using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class CustomerBaby
    {
        public CustomerBaby()
        {
            Customer = new Customer();
        }
        public virtual int BabyID { get; set; }
        public virtual string BabyName { get; set; }
        public virtual string NickName { get; set; }
        public virtual DateTime DateOfBirth { get; set; }
        public virtual bool Gender { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual Customer Customer { get; set; }
    }
}
