using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class CustomerGroup
    {
        public CustomerGroup()
        {
            CustomerList = new List<Customer>();
        }
        public virtual string CustomerGroupID { get; set; }
        public virtual string CustomerGroupName { get; set; }
        public virtual string Note { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual IList<Customer> CustomerList { get; set; }
    }
}
