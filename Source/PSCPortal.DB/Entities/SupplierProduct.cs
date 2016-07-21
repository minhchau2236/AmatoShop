using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class SupplierProduct
    {
        public SupplierProduct()
        {
            Supplier = new Supplier();
            Product = new Product();
        }
        public virtual Supplier Supplier { get; set; }
        public virtual Product Product { get; set; }
        public virtual decimal Price { get; set; }
        public virtual string Note { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as SupplierProduct;
            if (t == null)
                return false;
            if (Supplier == t.Supplier && Product == t.Product)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (Supplier.SupplierID + "|" + Product.ProductID).GetHashCode();
        }
    }
}
