using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PSCPortal.DB.Entities;
using PSCPortal.DB;
using PSCPortal.DB.Helper;
using NHibernate.Linq;

namespace PSCPortal
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionManager.DoWork(session =>
            {
                Product product = session.Query<Product>().FirstOrDefault();
                List<Product> lists = session.Query<Product>().ToList();
            });

        }
    }
}