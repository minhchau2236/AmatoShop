using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class ShippingFeE
    {
        public ShippingFeE()
        {

        }
        public virtual int ShippingFeeID { get; set; }
        public virtual string CityID { get; set; }
        public virtual string DistrictID { get; set; }
        public virtual decimal ShippingFee { get; set; }

    }
}
