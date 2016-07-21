using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Unit
    {
        public Unit()
        {
            BillDetailList = new List<BillDetail>();
            ProductList = new List<Product>();
            ProductPriceList = new List<ProductPrice>();
            WarehouseDetailList = new List<WarehouseDetail>();
        }
        public virtual string UnitID { get; set; }
        public virtual string UnitName { get; set; }
        public virtual List<BillDetail> BillDetailList { get; set; }
        public virtual List<Product> ProductList { get; set; }
        public virtual List<ProductPrice> ProductPriceList { get; set; }
        public virtual List<WarehouseDetail> WarehouseDetailList { get; set; }
    }
}
