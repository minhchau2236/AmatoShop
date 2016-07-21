using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class BillPhotoIdenfifier
    {
        public int PhotoId { get; set; }
        public int BillId { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as BillPhotoIdenfifier;
            if (t == null)
                return false;
            if (PhotoId == t.PhotoId && BillId == t.BillId)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (BillId + "|" + PhotoId).GetHashCode();
        }
    }
    public class BillPhoto
    {
        public BillPhoto()
        {
            Identifier = new BillPhotoIdenfifier();
        }
        public virtual BillPhotoIdenfifier Identifier { get; set; }
    }
}
