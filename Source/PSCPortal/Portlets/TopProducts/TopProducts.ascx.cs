using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PSCPortal.DB.Entities;
using PSCPortal.DB;
using PSCPortal.DB.Helper;
using NHibernate.Linq;
using System.Web.Script.Serialization;
using PSCPortal.DB.DTO;
using PSCPortal.CMS.Amato;

namespace PSCPortal.Portlets.TopProducts
{
    public partial class TopProducts : Engine.PortletControl
    {
        public string DataListProducts { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            ProtletProductsDisplayCollection listProductDisplay = ProtletProductsDisplayCollection.GetProtletProductsDisplayCollectionByDataId(Portlet.PortletInstance.Id);
            SessionManager.DoWork(session =>
            {
                //Product product = session.Query<Product>().FirstOrDefault();
                //List<Product> lists = session.Query<Product>().OrderByDescending(p => p.CreatedDate).Take(4).ToList();

                //List<Product> products = session.Query<Product>().OrderByDescending(p => p.CreatedDate).Take(4).ToList();

                List<Product> products = new List<Product>();
                foreach (ProtletProductsDisplay pt in listProductDisplay)
                {
                    var product = session.Query<Product>().SingleOrDefault(a => a.ProductID == pt.ProductId);
                    products.Add(product);
                }
                //if (products.Count != 4)
                //    products = session.Query<Product>().OrderByDescending(p => p.CreatedDate).Take(4).ToList();

                List<ProductDTO> Result = new List<ProductDTO>();
                foreach (Product p in products)
                {
                    ProductDTO simP = new ProductDTO();
                    simP.ProductID = p.ProductID;
                    simP.ProductName = p.ProductName;
                    simP.PhotoIds = p.ProductPhotoList.Select(a => a.PhotoID).ToList();
                    simP.Specifications = Photo.quote(p.Specifications);
                    Result.Add(simP);
                }

                JavaScriptSerializer js = new JavaScriptSerializer();
                DataListProducts = js.Serialize(Result);
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