using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
   public class TransactionType
    {
       public TransactionType()
       {
           TransactionList = new List<Transaction>();
       }
       public virtual string TransactionTypeID { get; set; }
       public virtual string TransactionTypeName { get; set; }
       public virtual bool IsNegative { get; set; }
       public virtual string Note { get; set; }
       public virtual string RelativeTableName { get; set; }
       public virtual IList<Transaction> TransactionList { get; set; }
    }
}
