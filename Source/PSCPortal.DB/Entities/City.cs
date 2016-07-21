using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
   public class City
    {
       public City()
       {
       }
       public virtual string CityID { get; set; }
       public virtual string CityName { get; set; }
    }
}
