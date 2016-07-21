using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Bill
    {
        public Bill()
        {
            Customer = new Customer();
            BillDetailList = new List<BillDetail>();
            BillPaymentList = new List<BillPayment>();
            BillPhotoList = new List<BillPhoto>();
            BillStatusList = new List<BillStatus>();
        }
        public virtual int BillID { get; set; }
        public virtual string BillNumber { get; set; }
        public virtual DateTime PurchasedDate { get; set; }
        public virtual decimal TotalAmount { get; set; }
        public virtual decimal DiscountPercent { get; set; }
        public virtual decimal DiscountAmount { get; set; }
        public virtual string ShippingContact { get; set; }
        public virtual string ShippingAddress { get; set; }
        public virtual string ShippingCityID { get; set; }
        public virtual string ShippingDistrictID { get; set; }
        public virtual string ShippingPhone { get; set; }
        public virtual string ShippingNote { get; set; }
        public virtual decimal ShippFee { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }

        public virtual Customer Customer { get; set; }
        public virtual IList<BillDetail> BillDetailList { get; set; }
        public virtual IList<BillPayment> BillPaymentList { get; set; }
        public virtual IList<BillPhoto> BillPhotoList { get; set; }
        public virtual IList<BillStatus> BillStatusList { get; set; }
    }
}
