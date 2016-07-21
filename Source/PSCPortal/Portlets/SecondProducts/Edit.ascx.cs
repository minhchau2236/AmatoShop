using System;
using System.Linq;
using System.Web.UI.WebControls;
using PSCPortal.DB.Helper;
using PSCPortal.DB.Entities;
using PSCPortal.DB.DTO;
using NHibernate.Linq;
using PSCPortal.CMS.Amato;
using Telerik.Web.UI;

namespace PSCPortal.Portlets.SecondProducts
{
    public partial class Edit : Engine.PortletEditControl
    {        
        protected int NumberArticle
        {
            get
            {
                return (int)ViewState["NumberArticle"];
            }
            set
            {
                ViewState["NumberArticle"] = value;
            }
        }        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadListTopic();
                LoadData();
            }
        }
        protected void LoadListTopic()
        {
            SessionManager.DoWork(session =>
            {
                var Collections = session.Query<Collection>().ToList();
                //lbxTopicSource.DataSource = Collections;
                //lbxTopicSource.DataTextField = "CollectionName";
                //lbxTopicSource.DataValueField = "CollectionID";
                //lbxTopicSource.DataBind();

                drlCollection.DataSource= session.Query<Collection>().ToList();
                drlCollection.DataTextField = "CollectionName";
                drlCollection.DataValueField = "CollectionID";
                drlCollection.DataBind();
            });

            //lbxTopicSource.DataSource = CMS.TopicCollection.GetTopicCollection();
           
        }
        protected void LoadData()
        {
            //gvProduct.DataKeyNames = new[] { "DataId", "TopicId" };
            
            gvListProduct.DataSource = ProtletProductsDisplayCollection.GetProtletProductsDisplayCollectionByDataId(DataId);
            gvListProduct.DataKeyNames = new[] { "DataId", "ProductId" };
            gvListProduct.DataBind();

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            ProtletProductsDisplayCollection portletProductsDisplayTopic = ProtletProductsDisplayCollection.GetProtletProductsDisplayCollectionByDataId(DataId);
            foreach (GridDataItem item in gvProduct.MasterTableView.Items)
            {
                if (item.Selected)
                {
                    string testKey = item["ProductName"].ToString();
                    string strKey = item.GetDataKeyValue("ProductID").ToString();/* item.GetDataKeyValue("ProductID").ToString();*/
                }
            }

            for (int i = 0; i < gvProduct.Items.Count; i++)
            {
                if (gvProduct.Items[i].Selected)
                {
                    var productId = gvProduct.Items[i].GetDataKeyValue("ProductID");
                    ProtletProductsDisplay product = new ProtletProductsDisplay
                    {
                        DataId = DataId,
                        //OrderNumber = txtNumberAirticle.Text != "" ? int.Parse(txtNumberAirticle.Text) : 0,
                        ProductId =Convert.ToInt32(hddProductId.Value)
                    };
                    portletProductsDisplayTopic.AddDB(product);

                }
                LoadData();
            }

        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            Accept();
        }

        protected void gvListProduct_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            ProtletProductsDisplayCollection ListTabDisplayTopic = ProtletProductsDisplayCollection.GetProtletProductsDisplayCollectionByDataId(DataId);
            var dataKey = gvListProduct.DataKeys[e.RowIndex];
            if (dataKey != null)
            {
                if (dataKey.Values != null)
                {
                    Guid dataId = new Guid(dataKey.Values[0].ToString());
                    int productId = Convert.ToInt32(dataKey.Values[1].ToString());
                    ProtletProductsDisplay tabTopic = new ProtletProductsDisplay();
                    foreach (ProtletProductsDisplay item in ListTabDisplayTopic)
                    {
                        if (item.DataId == dataId && item.ProductId == productId)
                        {
                            tabTopic = item;

                        }
                    }
                    ListTabDisplayTopic.RemoveDB(tabTopic);
                }
            }
            LoadData();
        }

        protected void gvListProduct_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            ProtletProductsDisplayCollection ListTabDisplayTopic = ProtletProductsDisplayCollection.GetProtletProductsDisplayCollectionByDataId(DataId);
            gvListProduct.EditIndex = -1;
            var dataKey = gvListProduct.DataKeys[e.RowIndex];
            if (dataKey != null)
            {
                if (dataKey.Values != null)
                {
                    int productId = ((int)dataKey.Values[1]);
                    ProtletProductsDisplay tab = ListTabDisplayTopic.Single(t => t.ProductId == productId);                 
                    int numberOrder = int.Parse(((TextBox)gvListProduct.Rows[e.RowIndex].Cells[1].Controls[0]).Text);                  
                    tab.OrderNumber = numberOrder;
                    tab.Update();
                }
            }
            LoadData();
        }

        protected void gvListProduct_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvListProduct.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvListProduct_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvListProduct.EditIndex = -1;
            LoadData();

        }
    }
}