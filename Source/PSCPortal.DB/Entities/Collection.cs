using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Collection
    {
        public Collection()
        {
            ProductList = new List<Product>();
        }
        public virtual string CollectionID { get; set; }
        public virtual string CollectionName { get; set; }

        public virtual string Note { get; set; }
        public virtual string ParentID { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual IList<Product> ProductList { get; set; }
    }
}
