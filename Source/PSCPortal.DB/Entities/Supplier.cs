using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Supplier
    {
        public Supplier()
        {
            SupplierProductList = new List<SupplierProduct>();
            WarehouseList = new List<Warehouse>();
        }
        public virtual string SupplierID { get; set; }
        public virtual string SupplierName { get; set; }
        public virtual string Address { get; set; }
        public virtual string WebsiteUrl { get; set; }
        public virtual string PhoneNumber { get; set; }
        public virtual string Fax { get; set; }
        public virtual string BankAccount { get; set; }
        public virtual string ContactName { get; set; }
        public virtual string ContactEmail { get; set; }
        public virtual string ContactPhone { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual IList<SupplierProduct> SupplierProductList { get; set; }
        public virtual IList<Warehouse> WarehouseList { get; set; }
    }
}
