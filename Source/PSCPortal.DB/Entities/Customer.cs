using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Customer
    {
        public Customer()
        {
            CustomerGroup = new CustomerGroup();
            BillList = new List<Bill>();
            CustomerBabyList = new List<CustomerBaby>();
        }
        public virtual int CustomerID { get; set; }
        public virtual string CustomerCode { get; set; }
        public virtual string CustomerName { get; set; }
        public virtual string DateOfBirth { get; set; }
        public virtual int Gender { get; set; }
        public virtual string PhoneNumber { get; set; }
        public virtual string Email { get; set; }
        public virtual string IdentityNumber { get; set; }
        public virtual string BankAccount { get; set; }
        public virtual DateTime LastAccessDate { get; set; }
        public virtual bool AllowReceiveEmail { get; set; }
        public virtual string Pw { get; set; }
        public virtual string ShippingContact { get; set; }
        public virtual string ShippingAddress { get; set; }
        public virtual string ShippingCityID { get; set; }
        public virtual string ShippingDistrictID { get; set; }
        public virtual string ShippingPhone { get; set; }
        public virtual string ShippingNote { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }

        public virtual CustomerGroup CustomerGroup { get; set; }
        public virtual IList<Bill> BillList { get; set; }
        public virtual IList<CustomerBaby> CustomerBabyList { get; set; }
    }
}
