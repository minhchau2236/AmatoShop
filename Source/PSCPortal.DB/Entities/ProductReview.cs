using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Entities
{
    public class ProductReview
    {
        public ProductReview()
        {
            Product = new Product();
        }
        public virtual int ProductReviewID { get; set; }
        public virtual string Email { get; set; }
        public virtual string CustomerName { get; set; }
        public virtual string PhoneNumber { get; set; }
        public virtual string ReviewContent { get; set; }
        public virtual DateTime SentDate { get; set; }
        public virtual string ReviewReply { get; set; }
        public virtual DateTime ReplyDate { get; set; }
        public virtual int ReplyBy { get; set; }
        public virtual bool ShowOnWeb { get; set; }
        public virtual Product Product { get; set; }
    }
}
