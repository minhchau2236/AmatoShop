using PSCPortal.Framework;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.DTO
{
    public class ProductDTO
    {
        public ProductDTO()
        {
            PhotoIds = new List<int>();
        }
        public int ProductID { get; set; }
        public string ProductCode { get; set; }
        public string ProductCodeBrand { get; set; }
        public string ProductName { get; set; }
        public List<int> PhotoIds { get; set; }
        public string Specifications { get; set; }

    }
}
