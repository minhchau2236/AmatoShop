using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class BillPaymentIdenfifier
    {
        public int BillId { get; set; }
        public int TransactionId { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as BillPaymentIdenfifier;
            if (t == null)
                return false;
            if (BillId == t.BillId && TransactionId == t.TransactionId)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (BillId + "|" + TransactionId).GetHashCode();
        }
    }
    public class BillPayment
    {
        public BillPayment()
        {
            Identifier = new BillPaymentIdenfifier();
        }
        public virtual BillPaymentIdenfifier Identifier { get; set; }
        public virtual string PaymentInfo { get; set; }
        public virtual int BillPaymentNumber { get; set; }
    }
}
