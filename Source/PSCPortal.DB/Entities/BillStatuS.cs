using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class BillStatusIdenfifier
    {
        public int BillStatus { get; set; }
        public int BillId { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as BillStatusIdenfifier;
            if (t == null)
                return false;
            if (BillStatus == t.BillStatus && BillId == t.BillId)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (BillId + "|" + BillStatus).GetHashCode();
        }
    }
    public class BillStatus
    {
        public BillStatus()
        {
            Identifier = new BillStatusIdenfifier();
        }
        public virtual BillStatusIdenfifier Identifier { get; set; }
        public virtual DateTime StatusDate { get; set; }
        public virtual string Note { get; set; }
    }
}
