<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductDispaly.ascx.cs" Inherits="PSCPortal.Modules.Amato.ProductDispaly" %>
<style>
    .shareImg {
        height: 30px;
        width: 30px;
    }
</style>
<script>
    function changePic(divId, id) {
        var src = 'services/GetProductImage.ashx?Id=' + id;
        $("#productImg").fadeOut(100, function () { $("#productImg").attr("src", src) }).fadeIn();

        $('#imgDiv0').removeClass('active');
        $('#imgDiv1').removeClass('active');
        var divId = '#' + divId;
        $(divId).addClass('active');
    }
</script>
<div class="main-product-wrap product-wrap" itemscope="" itemtype="#" data-product-id="1206793093" style="padding-bottom: 50px;">
    <div class="product-images">
        <div class="product-main-image">
            <img id="productImg" alt="Warm Wishes Bowls" style="height: 500px;" src="services/GetProductImage.ashx?Id=<%#ProductShow.PhotoIds[0]%>">
            <div class="product-zoom"></div>
        </div>
        <div class="product-thumbnails-outer-wrapper">
            <div class="product-thumbnails-wrapper">
                <div class="product-thumbnails ">
                    <div id="imgDiv0" class="product-thumbnail active" onclick="changePic('imgDiv0',<%#ProductShow.PhotoIds[0]%>);">
                        <img alt="Warm Wishes Bowls" data-high-res="images/ww-15-1_compact.jpeg" src="services/GetProductImage.ashx?Id=<%#ProductShow.PhotoIds[0]%>">
                    </div>

                    <div id="imgDiv1" class="product-thumbnail" onclick="changePic('imgDiv1',<%#ProductShow.PhotoIds[1]%>);">
                        <img alt="Warm Wishes Bowls" data-high-res="images/ww-15-1_compact.jpeg" src="services/GetProductImage.ashx?Id=<%#ProductShow.PhotoIds[1]%>">
                    </div>

                </div>
            </div>

        </div>
    </div>

    <div class="product-details-wrapper">
        <div class="product-details">
            <a class="product-vendor" href="#">Wind and Willow</a>

            <h1 class="product-title" itemprop="name"><%=ProductShow.ProductName%></h1>
            <p class="product-price" itemprop="offers" itemscope="" itemtype="http://schema.org/Offer">
                <span class="product-price-minimum money"></span>
                <span class="product-price-compare money"></span>
                <link itemprop="availability" href="#">
            </p>

            <form action="#" method="post" id="product-form-1206793093">
                <div class="product-quantity inline-input-wrapper">
                    <label>Quantity</label>
                    <input type="text" name="quantity" value="1">
                </div>
                <div class="share-buttons">
                    <table style="border: none; padding: 0;">
                        <tr style="border: none;">
                            <td style="border: none; padding: 0;">
                                <div class="section-title" style="">Share</div>
                            </td>
                            <td style="border: none; padding: 0;">
                                <a target="_blank" href="#">
                                    <img title="Facebook" class="shareImg" src="../../assets/SocialIcon/face-book-icon.png" /></a>
                                <a target="_blank" href="#">
                                    <img title="Google+" class="shareImg" src="../../assets/SocialIcon/g-icon.png" /></a>
                                <a target="_blank" href="#">
                                    <img title="Twitter" class="shareImg" src="../../assets/SocialIcon/twitter-icon.png" /></a>
                                <a target="_blank" href="#">
                                    <img title="Pinterest" class="shareImg" src="../../assets/SocialIcon/pinterest-icon.png" /></a>
                            </td>
                        </tr>
                    </table>
                    <%--<a target="_blank" href="//www.facebook.com/sharer.php?u=http://grid-theme-light.myshopify.com/products/warm-wishes-bowls" class="share-facebook"></a>
                    <a target="_blank" href="//twitter.com/share?url=http://grid-theme-light.myshopify.com/products/warm-wishes-bowls" class="share-twitter"></a>
                    <a target="_blank" href="//pinterest.com/pin/create/button/?url=http://grid-theme-light.myshopify.com/products/warm-wishes-bowls&amp;media=http://cdn.shopify.com/s/files/1/0930/7834/products/ww-15-1_1024x1024.jpeg?v=1437430688&amp;description=Warm Wishes Bowls" class="share-pinterest"></a>
                    <a target="_blank" href="http://www.thefancy.com/fancyit?ItemURL=http://grid-theme-light.myshopify.com/products/warm-wishes-bowls&amp;Title=Warm Wishes Bowls&amp;Category=Other&amp;ImageURL=//cdn.shopify.com/s/files/1/0930/7834/products/ww-15-1_1024x1024.jpeg?v=1437430688" class="share-fancy"></a>
                    <a target="_blank" href="//plus.google.com/share?url=http://grid-theme-light.myshopify.com/products/warm-wishes-bowls" class="share-google"></a>
                    <a target="_blank" href="mailto:?subject=Warm Wishes Bowls&amp;body=Check this out http://grid-theme-light.myshopify.com/products/warm-wishes-bowls" class="share-email"></a>--%>
                </div>
                <div class="add-to-cart">
                    <input type="submit" value="Add to cart">
                </div>
                <div class="product-message"></div>

            </form>


            <div class="product-description rte" itemprop="description">
                <meta charset="utf-8">
                <span><%=ProductShow.Specifications%></span>
            </div>


        </div>
    </div>

</div>
