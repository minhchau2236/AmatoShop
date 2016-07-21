using System;
using System.Linq;
using System.Web.UI.WebControls;
using PSCPortal.Engine;
using System.Configuration;
using PSCPortal.CMS;


namespace PSCPortal.Libs
{
    public class PageEngine : System.Web.UI.UserControl
    {

       public bool Edit { get; set; }
       public Page PagePortal
        {
            get
            {
                return ViewState["PagePortal"] as Page;
            }
            set
            {
                ViewState["PagePortal"] = value;
            }
        }
        
        protected PanelInPageCollection PanelInPageList
        {
            get
            {
                if (ViewState["PanelInPageList"] == null && PagePortal != null)
                    ViewState["PanelInPageList"] = PanelInPageCollection.GetPanelInPageCollection(PagePortal);
                return ViewState["PanelInPageList"] as PanelInPageCollection;
            }
            set
            {
                ViewState["PanelInPageList"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs eventArgs)
        {
            IPanelArgs args = null;
            string articleId = Page.RouteData.Values["Id"] != null ? Page.RouteData.Values["Id"].ToString() : Request.QueryString["ArticleId"];
            string topicId = Page.RouteData.Values["TopicId1"] != null ? Page.RouteData.Values["TopicId1"].ToString() : Request.QueryString["TopicId"];           
            string moduleId = Page.RouteData.Values["ModuleId"] != null ? Page.RouteData.Values["ModuleId"].ToString() : Request.QueryString["ModuleId"];
            string productId = Page.RouteData.Values["ProductId"] != null ? Page.RouteData.Values["ProductId"].ToString() : Request.QueryString["ProductId"];
            string collectionId = Page.RouteData.Values["CollectionId"] != null ? Page.RouteData.Values["CollectionId"].ToString() : Request.QueryString["CollectionId"];
            if (topicId != null)
            {
                int index = topicId.IndexOf("/");
                if (index > 0)
                    topicId = topicId.Substring(0, index);
                var topic = Topic.GetTopic(topicId);
                if (topic.PageId != PagePortal.Id)
                    ChangePage(topic.PageId);
                var topicArgs = new Engine.TopicArgs(topic.PageId);
                if (topic.Rss)
                    Response.Redirect("~/Services/RssHandler.ashx?TopicId=" + topic.Id);
                args = topicArgs;
            }
            else if (articleId != null)
            {
                int index = articleId.IndexOf("/");
                int review = articleId.IndexOf("Preview");
                if (index > 0)
                    articleId = articleId.Substring(0, index);
                Article article = review > -1 ? Article.GetArticleUnPublish(articleId) : Article.GetArticle(articleId);
                if (article.PageId != PagePortal.Id)
                    ChangePage(article.PageId);
                var articleArgs = new Engine.ArticleArgs();
                Layout layout = LayoutCollection.GetPageLayOut(article.PageId).SingleOrDefault();
                if (layout != null)
                {
                    if (layout.Id != Guid.Empty)
                        articleArgs.Path = layout.NavigationUrl ; // ConfigurationManager.AppSettings["ArticleDisplay"] + layout.Name + ".ascx";
                }
                args = articleArgs;
            }
            else if (moduleId != null)
            {
                int index = moduleId.IndexOf("/");
                if (index > 0)
                    moduleId = moduleId.Substring(0, index);
                var moduleArgs = new ModuleDipslayArgs { moduleId = moduleId };
                var moudule = Module.GetModule(moduleId);
                if (moudule.Id.ToString() == ConfigurationManager.AppSettings["ModuleAlbum"] ||
                    moudule.Id.ToString() == ConfigurationManager.AppSettings["ModuleVideoClip"] || moduleId == ConfigurationManager.AppSettings["ModuleSiteMap"])
                    ChangePage(new Guid(SubDomain.GetPage(Libs.Ultility.GetSubDomain())));
                else if (moudule.PageId != PagePortal.Id)
                    ChangePage(moudule.PageId);
                args = moduleArgs;
            }
            else if (productId != null)
            {


                int index = productId.IndexOf("/");
                if (index > 0)
                    moduleId = productId.Substring(0, index);
                var moduleArgs = new ModuleDipslayArgs { moduleId = "9cd5da00-2783-4277-97b7-6f3762274a97" };
                var moudule = Module.GetModule(moduleArgs.moduleId);
                
                args = moduleArgs;
            }
            else if (collectionId != null)
            {


                int index = collectionId.IndexOf("/");
                if (index > 0)
                    moduleId = collectionId.Substring(0, index);
                var moduleArgs = new ModuleDipslayArgs { moduleId = "27b81fbb-5c55-4623-aa1d-0bf2c9b7685b" };
                var moudule = Module.GetModule(moduleArgs.moduleId);
               
                args = moduleArgs;
            }
            foreach (var control in Controls)
            {
                var phDisplay = control as PlaceHolder;
                if (phDisplay != null)
                {
                              //phDisplay.Controls.Add(PanelInPageList.RenderTable(args, false));
                              phDisplay.Controls.Add(PanelInPageList.RenderDIV(args, Edit));
                              break;
                }
            }
        }

        protected void ChangePage(Guid pageId)
        {
            PagePortal = Engine.Page.GetPage(pageId);
            PanelInPageList = PanelInPageCollection.GetPanelInPageCollection(PagePortal);
            int language = Engine.Page.GetPage(pageId).Language;
            //language = 1 => vi-vn, language = 2 => en-us
            Page.UICulture = language == 1 ? "vi-vn" : "en-us";
        }
    }
}