using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using PSCPortal.DB.Helper;
using PSCPortal.DB.Entities;
using PSCPortal.DB.DTO;
using NHibernate.Linq;
using System.Web.Script.Serialization;

namespace PSCPortal.Services
{
    /// <summary>
    /// Summary description for AmatoService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AmatoService : System.Web.Services.WebService
    {
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string GetProductsbyName(string key, int startIndex, int pageSize)
        {
            string result = "";
            List<ProductDTO> productDTOs = new List<ProductDTO>();
            Dictionary<string, object> resultDic = new Dictionary<string, object>();
            SessionManager.DoWork(session =>
            {
                productDTOs = session.Query<Product>().Where(a => a.ProductCode != "1234" && a.ProductName.Contains(key))
                .Select(a => new ProductDTO() { ProductID = a.ProductID, ProductName = a.ProductName })
                .Skip(startIndex).Take(pageSize).ToList();

                int count = session.Query<Product>().Count();
                resultDic["data"] = productDTOs;
                resultDic["count"] = count;
            });

            JavaScriptSerializer js = new JavaScriptSerializer();
            result = js.Serialize(resultDic);

            return result;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string GetProductsbyCollection(string collectionId, int startIndex, int pageSize)
        {
            string result = "";
            List<ProductDTO> productDTOs = new List<ProductDTO>();
            Dictionary<string, object> resultDic = new Dictionary<string, object>();
            SessionManager.DoWork(session =>
            {
                productDTOs = session.Query<Product>().Where(a => a.ProductCode != "1234" && a.Collection.CollectionID == collectionId)
                .Select(a => new ProductDTO() { ProductID = a.ProductID, ProductName = a.ProductName })
                .Skip(startIndex).Take(pageSize).ToList();

                int count = session.Query<Product>().Count();
                resultDic["data"] = productDTOs;
                resultDic["count"] = count;
            });

            JavaScriptSerializer js = new JavaScriptSerializer();
            result = js.Serialize(resultDic);

            return result;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string GetProducts(int startIndex, int pageSize)
        {
            string result = "";
            List<ProductDTO> productDTOs = new List<ProductDTO>();
            Dictionary<string, object> resultDic = new Dictionary<string, object>();
            SessionManager.DoWork(session =>
            {
                productDTOs = session.Query<Product>().Where(a => a.ProductCode != "1234")
                .Select(a => new ProductDTO() { ProductID = a.ProductID, ProductName = a.ProductName })
                .Skip(startIndex).Take(pageSize).ToList();

                int count = session.Query<Product>().Count();
                resultDic["data"] = productDTOs;
                resultDic["count"] = count;
            });

            JavaScriptSerializer js = new JavaScriptSerializer();
            result = js.Serialize(resultDic);

            return result;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string GetAllProducts()
        {
            string result = "";
            List<ProductDTO> productDTOs = new List<ProductDTO>();
            Dictionary<string, object> resultDic = new Dictionary<string, object>();
            SessionManager.DoWork(session =>
            {
                productDTOs = session.Query<Product>().Where(a => a.ProductCode != "1234")
                .Select(a => new ProductDTO() { ProductID = a.ProductID, ProductName = a.ProductName }).ToList();

                int count = session.Query<Product>().Count();
                resultDic["data"] = productDTOs;
                resultDic["count"] = count;
            });

            JavaScriptSerializer js = new JavaScriptSerializer();
            result = js.Serialize(resultDic);

            return result;
        }

        public class ProductListInfo
        {
            public int ProductId;
            public string ProductCode;
            public string ProductName;
            public string ProductPrice;
            public List<int> PhotoIds;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string GetProductListInfo(string collId, int pageSize, int pageIdx)
        {
            List<ProductListInfo> Result = new List<ProductListInfo>();
            SessionManager.DoWork(session =>
            {
                int skip = (pageIdx - 1) * pageSize;
                var temResult = session.Query<Product>().Where(p => p.Collection.CollectionID == collId).Skip(skip).Take(pageSize);
                foreach (Product item in temResult)
                {
                    ProductListInfo p = new ProductListInfo();
                    p.ProductId = item.ProductID;
                    p.ProductCode = item.ProductCode;
                    p.ProductName = item.ProductName;
                    p.ProductPrice = "0 Đ";
                    try
                    {
                        p.ProductPrice = session.Query<ProductPrice>().FirstOrDefault(c => c.Product.ProductID == p.ProductId).Price.ToString();
                    }
                    catch { }
                    p.PhotoIds = item.ProductPhotoList.Select(a => a.PhotoID).ToList();
                    Result.Add(p);
                }
            });

            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(Result);
        }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
    }
}
