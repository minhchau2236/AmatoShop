using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class WarehouseDetail
    {
        public WarehouseDetail()
        {
            Warehouse = new Warehouse();
            Product = new Product();
            Unit = new Unit();
        }
        public virtual Warehouse Warehouse { get; set; }
        public virtual Product Product { get; set; }
        public virtual decimal Quantity { get; set; }
        public virtual decimal Price { get; set; }
        public virtual decimal DiscountPercent { get; set; }
        public virtual decimal DiscountAmount { get; set; }
        public virtual string Note { get; set; }
        public virtual decimal ReceivedQuantity { get; set; }
        public virtual DateTime ReceivedDate { get; set; }
        public virtual int ReceivedBy { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual Unit Unit { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as WarehouseDetail;
            if (t == null)
                return false;
            if (Warehouse == t.Warehouse && Product == t.Product)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (Warehouse.WarehouseID+ "|" + Product.ProductID).GetHashCode();
        }
    }
}
