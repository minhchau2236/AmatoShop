using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PSCPortal.DB;
using PSCPortal.DB.Helper;
using PSCPortal.DB.Entities;
using PSCPortal.DB.DTO;
using PSCPortal.Help;
using NHibernate.Linq;
using System.Web.Script.Serialization;
using PSCPortal.CMS.Amato;

namespace PSCPortal.Portlets.SecondProducts
{
    public partial class Display : Engine.PortletControl
    {
        public string DataListProducts { get; set; }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            ProtletProductsDisplayCollection listProductDisplay = ProtletProductsDisplayCollection.GetProtletProductsDisplayCollectionByDataId(Portlet.PortletInstance.Id);
            SessionManager.DoWork(session=>{
                List<Product> products = new List<Product>();
              
                foreach (ProtletProductsDisplay pt in listProductDisplay)
                {
                    var product = session.Query<Product>().SingleOrDefault(a => a.ProductID == pt.ProductId);
                    products.Add(product);
                }
                List<ProductDTO> productDTOs = new List<ProductDTO>();
                foreach(Product p in products)
                {
                    ProductDTO npro = new ProductDTO();
                    npro.ProductID = p.ProductID;
                    npro.ProductName = p.ProductName;
                    npro.PhotoIds = p.ProductPhotoList.Select(a => a.PhotoID).ToList();
                    npro.Specifications =Photo.quote(p.Specifications);
                    productDTOs.Add(npro);
                }


                JavaScriptSerializer js=new JavaScriptSerializer();
                DataListProducts = js.Serialize(productDTOs);
            });

            DataBind();
        }

        protected override void DeleteData()
        {
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PSCPortalConnectionString"].ConnectionString))
            {
                SqlCommand com = new SqlCommand { Connection = con };
                con.Open();
                com.CommandType = System.Data.CommandType.Text;
                com.Parameters.AddWithValue("@dataId", Portlet.PortletInstance.Id);
                com.CommandText = "Delete PortletTabTopicDisplay Where DataId=@dataId";
                com.ExecuteNonQuery();
            }
        }
    }
}