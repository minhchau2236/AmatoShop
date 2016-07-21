using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class BillPaymentPhotoIdenfifier
    {
        public int BillPaymentNumber { get; set; }
        public int PhotoId { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as BillPaymentPhotoIdenfifier;
            if (t == null)
                return false;
            if (BillPaymentNumber == t.BillPaymentNumber && PhotoId == t.PhotoId)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (BillPaymentNumber + "|" + PhotoId).GetHashCode();
        }
    }
    public class BillPaymentPhoto
    {
        public BillPaymentPhoto()
        {
            Identifier = new BillPaymentPhotoIdenfifier();
        }
        public virtual BillPaymentPhotoIdenfifier Identifier { get; set; }
    }
}
