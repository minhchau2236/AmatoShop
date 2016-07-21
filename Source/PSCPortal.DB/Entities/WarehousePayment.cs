using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class WarehousePayment
    {
        public WarehousePayment()
        {
            Warehouse = new Warehouse();
            Transaction = new Transaction();
        }
        public virtual Warehouse Warehouse { get; set; }
        public virtual Transaction Transaction { get; set; }
        public virtual string PaymentInfo { get; set; }
        public virtual int WarehousePaymentNumber { get; set; }
        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            var t = obj as WarehousePayment;
            if (t == null)
                return false;
            if (Warehouse == t.Warehouse && Transaction == t.Transaction)
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            return (Warehouse.WarehouseID + "|" + Transaction.TransactionID).GetHashCode();
        }
    }
}
