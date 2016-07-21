using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Brand
    {
        public Brand()
        {
            ProductList = new List<Product>();
        }
        public virtual string BrandID { get; set; }
        public virtual string BrandName { get; set; }
        public virtual string ContentHTML { get; set; }
        public virtual IList<Product> ProductList { get; set; }
    }
}
