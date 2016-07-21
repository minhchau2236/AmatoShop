using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class ProductPrice
    {
        public ProductPrice()
        {
            Unit = new Unit();
            Product = new Product();
        }
        public virtual int ProductPriceID { get; set; }
        public virtual decimal Price { get; set; }
        public virtual DateTime AppliedFrom { get; set; }
        public virtual DateTime AppliedTo { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual Unit Unit { get; set; }
        public virtual Product Product { get; set; }
    }
}
