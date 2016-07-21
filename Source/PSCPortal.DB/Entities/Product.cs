using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Product
    {
        public Product()
        {
            Collection = new Collection();
            Unit = new Unit();
            Brand = new Brand();
            BillDetailList = new List<BillDetail>();
            ProductReviewList = new List<ProductReview>();
            ProductPhotoList = new List<ProductPhoto>();
            SupplierProductList = new List<SupplierProduct>();
            WarehouseDetailList = new List<WarehouseDetail>();
            ProductPriceList = new List<ProductPrice>();
        }
        public virtual int ProductID { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string ProductCodeBrand { get; set; }
        public virtual string ProductName { get; set; }
        public virtual int MonthAgeFrom { get; set; }
        public virtual int MonthAgeTo { get; set; }
        public virtual string Specifications { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual Collection Collection { get; set; }
        public virtual Unit Unit { get; set; }
        public virtual Brand Brand { get; set; }
        public virtual IList<BillDetail> BillDetailList { get; set; }
        public virtual IList<ProductReview> ProductReviewList { get; set; }
        public virtual IList<ProductPhoto> ProductPhotoList { get; set; }
        public virtual IList<SupplierProduct> SupplierProductList { get; set; }
        public virtual IList<WarehouseDetail> WarehouseDetailList { get; set; }
        public virtual IList<ProductPrice> ProductPriceList { get; set; }
    }
}
