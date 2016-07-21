using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class Log
    {
        public Log()
        {
        }
        public virtual int LogId { get; set; }
        public virtual string MachineName { get; set; }
        public virtual string MachineIP { get; set; }
        public virtual string Script { get; set; }
        public virtual DateTime ExcuteDate { get; set; }
        public virtual string MethodName { get; set; }
        public virtual string Result { get; set; }
    }
}
