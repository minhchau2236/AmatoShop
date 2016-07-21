using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class BillDetailIdenfifier
    {
        public int BillId { get; set; }
        public int ProductId { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as BillDetailIdenfifier;
            if (t == null)
                return false;
            if (BillId == t.BillId && ProductId == t.ProductId)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (BillId + "|" + ProductId).GetHashCode();
        }
    }

    public class BillDetail
    {
        public BillDetail()
        {
            Identifier = new BillDetailIdenfifier();
            Unit = new Unit();
        }
        public virtual BillDetailIdenfifier Identifier { get; set; }
        public virtual decimal Quantity { get; set; }
        public virtual decimal Price { get; set; }
        public virtual decimal DiscountPercent { get; set; }
        public virtual decimal DiscountAmount { get; set; }
        public virtual string Note { get; set; }
        public virtual DateTime CreatedDate { get; set; }
        public virtual int CreatedBy { get; set; }
        public virtual DateTime LastUpdateDate { get; set; }
        public virtual int LastUpdateBy { get; set; }
        public virtual Unit Unit { get; set; }

       
    }
}
