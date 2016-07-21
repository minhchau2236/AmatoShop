using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PSCPortal.DB.Entities;
using PSCPortal.DB.DTO;
using PSCPortal.DB;
using PSCPortal.DB.Helper;
using NHibernate.Linq;


namespace PSCPortal.Modules.Amato
{
   
    public partial class ProductDispaly : System.Web.UI.UserControl
    {
        public string Name = "";
        public ProductDTO ProductShow = new ProductDTO();
        protected void Page_Load(object sender, EventArgs e)
        {
            ProductShow = GetCurrentProduct(Convert.ToInt32(Request.QueryString["ProductId"]));
            DataBind();
        }

        public ProductDTO GetCurrentProduct(int productId)
        {
            ProductDTO result = new ProductDTO();

            SessionManager.DoWork(session =>
            {
                Product p = session.Query<Product>().SingleOrDefault(a => a.ProductID == productId);
             
                result.ProductID = p.ProductID;
                result.ProductName = p.ProductName;
                result.PhotoIds = p.ProductPhotoList.Select(a => a.PhotoID).ToList();
                result.Specifications = Photo.quote(p.Specifications);
            });

            return result;
        }
    }
}