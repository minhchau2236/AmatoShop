using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Warehouse
    {
        public Warehouse()
        {
            Supplier = new Supplier();
            WarehouseDetailList = new List<WarehouseDetail>();
            WarehousePaymentList = new List<WarehousePayment>();
            WarehousePhotoList = new List<WarehousePhoto>();
        }
        public virtual int WarehouseID { get; set; }
        public virtual string WarehouseNumber { get; set; }
        public virtual DateTime FoundedDate { get; set; }
        public virtual DateTime WarehousedDate { get; set; }
        public virtual DateTime PurchasedDate { get; set; }
        public virtual string PurchasedBy { get; set; }
        public virtual string Note { get; set; }
        public virtual decimal TotalAmount { get; set; }
        public virtual decimal DiscountPercent { get; set; }
        public virtual decimal DiscountAmount { get; set; }
        public virtual bool Locked { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual Supplier Supplier { get; set; }
        public virtual IList<WarehouseDetail> WarehouseDetailList { get; set; }
        public virtual IList<WarehousePayment> WarehousePaymentList { get; set; }
        public virtual IList<WarehousePhoto> WarehousePhotoList { get; set; }

       
    }
}
