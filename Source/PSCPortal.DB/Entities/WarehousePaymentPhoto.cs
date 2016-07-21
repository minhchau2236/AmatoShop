using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
  public  class WarehousePaymentPhoto
    {
      public WarehousePaymentPhoto()
      {
      }
      public virtual int WarehousePaymentNumber { get; set; }
      public virtual int PhotoID { get; set; }

      public override bool Equals(object obj)
      {
          if (obj == null)
              return false;
          var t = obj as WarehousePaymentPhoto;
          if (t == null)
              return false;
          if (WarehousePaymentNumber == t.WarehousePaymentNumber && PhotoID == t.PhotoID)
              return true;
          return false;
      }
      public override int GetHashCode()
      {
          return (WarehousePaymentNumber + "|" + PhotoID).GetHashCode();
      }
    }
}
