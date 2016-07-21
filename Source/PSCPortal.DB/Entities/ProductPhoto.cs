using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{

    public class ProductPhoto
    {
        public ProductPhoto()
        {
            Product = new Product();
        }
        public virtual int PhotoID { get; set; }
        public virtual Product Product { get; set; }
        public virtual int SortNo { get; set; }
        public virtual int UserID { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as ProductPhoto;
            if (t == null)
                return false;
            if (PhotoID == t.PhotoID && Product == t.Product)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (PhotoID + "|" + Product.ProductID).GetHashCode();
        }
    }
}
