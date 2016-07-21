using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class DistrictIdenfifier
    {
        public int CityId { get; set; }
        public int DistrictId { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as DistrictIdenfifier;
            if (t == null)
                return false;
            if (CityId == t.CityId && DistrictId == t.DistrictId)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (CityId + "|" + DistrictId).GetHashCode();
        }
    }
    public class District
    {
        public District()
        {
            Identifier = new DistrictIdenfifier();
        }
        public virtual DistrictIdenfifier Identifier { get; set; }
        public virtual string DistrictName { get; set; }
    }
}
