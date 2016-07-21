using System;
using System.Web;

namespace PSCPortal.Services
{
    /// <summary>
    /// Summary description for GetImage
    /// </summary>
    public class GetProductImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["Id"] == string.Empty)
                return;
            int id = Convert.ToInt32(context.Request.QueryString["Id"]);
            //string option = context.Request.QueryString["option"];
            //string type = context.Request.QueryString["type"];
            byte[] _buffer = null;
            //switch (option)
            //{
            //    case "0":
            //        {
                        _buffer = PSCPortal.DB.Helper.Photo.GetImage(id);
            //            break;
            //        }
            //    default:
            //        {
            //            _buffer = PSCPortal.DB.Helper.Photo.GetImage(id);
            //            break;
            //        }
            //}

            if (_buffer == null)
            {
                string url = string.Empty;
                //switch (type)
                //{
                //    case "0":
                //        {
                            url = "~/Resources/ImagePhoto/arrow_topic.png";
                //            break;
                //        }
                //    default:
                //        {
                //            url = "~/Resources/ImagePhoto/noimage.jpg";
                //            break;
                //        }
                //}

                _buffer = System.IO.File.ReadAllBytes(context.Server.MapPath(url));
            }
            context.Response.ContentType = "image/Jpeg";
            context.Response.BinaryWrite(_buffer);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}