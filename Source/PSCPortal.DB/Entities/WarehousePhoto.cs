using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class WarehousePhoto
    {
        public WarehousePhoto()
        {
            Warehouse = new Warehouse();
        }
        public virtual int PhotoID { get; set; }
        public virtual Warehouse Warehouse { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as WarehousePhoto;
            if (t == null)
                return false;
            if (PhotoID == t.PhotoID && Warehouse == t.Warehouse)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (PhotoID + "|" + Warehouse.WarehouseID).GetHashCode();
        }
    }
}
