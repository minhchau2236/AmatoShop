using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Transaction
    {
        public Transaction()
        {
            TransactionType = new TransactionType();
            BillPaymentList = new List<BillPayment>();
            WarehousePaymentList = new List<WarehousePayment>();
        }
        public virtual int TransactionID { get; set; }
        public virtual decimal Amount { get; set; }
        public virtual int AccountID { get; set; }
        public virtual string Descriptions { get; set; }
        public virtual DateTime TransactionDate { get; set; }
        public virtual bool IsDeleted { get; set; }
        public virtual bool IsBlocked { get; set; }
        public virtual int UserID { get; set; }
        public virtual TransactionType TransactionType { get; set; }
        public virtual IList<BillPayment> BillPaymentList { get; set; }
        public virtual IList<WarehousePayment> WarehousePaymentList { get; set; }
    }
}
