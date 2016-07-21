<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopProducts.ascx.cs" Inherits="PSCPortal.Portlets.TopProducts.TopProducts" %>

<style>
    #MainDiv {
        height: 1000px;
        background-color: purple;
    }
</style>

<script>
    var top4ProductsJS = function () {
        var self = this;
        self.top4ProductsdataList = pscjq.parseJSON('<%#DataListProducts%>');
    }

    var spVM = null;

    pscjq(document).ready(
        function () {
            spVM = new top4ProductsJS();
            ko.applyBindings(spVM, $("#top4Products")[0]);
        });
</script>

<section id="top4Products" class="template-index  has-promo  has-quick-shop">

    <%--<div data-bind="html: top4ProductsdataList[0].ProductName"></div>
    <img alt="Large Bowls" data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[0].PhotoIds[1] }" />
    <div data-bind="html: top4ProductsdataList[1].ProductName"></div>
    <img alt="Large Bowls" data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[1].PhotoIds[1] }" />
    <div data-bind="html: top4ProductsdataList[2].ProductName"></div>
    <img alt="Large Bowls" data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[2].PhotoIds[1] }" />
    <div data-bind="html: top4ProductsdataList[3].ProductName"></div>
    <img alt="Large Bowls" data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[3].PhotoIds[1] }" />--%>

    <!-- ko foreach: top4ProductsdataList -->
    <%-- <div data-bind="html: ProductName"></div>
    <img alt="Large Bowls" data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + PhotoIds[0] }" />--%>
    <!-- /ko -->



    <div class="masonry-features-wrapper has-animation">
        <section class="masonry-features has-6-features" style="margin-bottom: 10px;">
            <article class="masonry-feature feature-1 color-black enable-mobile-false has-link" data-url="http://grid-theme-minimal.myshopify.com/collections/limited-edition" style="padding-bottom: 28%;">
                <figure class="no-image" style="padding-bottom: 97.048%;"></figure>
                <div class="masonry-feature-text" style="margin-top: -15%; margin-left: -45%;">
                    <p class="masonry-feature-title">
                        <a href="#">Last chance to shop the winter collection.
                        </a>
                    </p>
                    <p class="masonry-feature-subtitle">
                        <a href="#">Take 20% off all weekend with the discount code: LASTCHANCE
                        </a>
                    </p>
                </div>
            </article>
            <article class="masonry-feature feature-2 color-black enable-mobile-false has-link" data-url="#">
                <a class="" data-bind="attr: { href: '/?ProductId=' + top4ProductsdataList[0].ProductID }">
                    <figure class="no-image" style="padding-bottom: 97.048%;">
                        <img data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[0].PhotoIds[1] }" <%--src="../../assets/masonry-feature-2-image87d4.jpg"--%> alt="grid-theme-light" style="height: auto; width: 100%; object-fit: cover; /*margin-top: -102.5px; */" />
                    </figure>
                </a>
            </article>
            <article class="masonry-feature feature-3 color-black enable-mobile-false has-link" data-url="#">
                <a class="" data-bind="attr: { href: '/?ProductId=' + top4ProductsdataList[1].ProductID }">
                    <figure class="no-image" style="padding-bottom: 71.8519%;">
                        <img data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[1].PhotoIds[1] }" <%--src="../../assets/masonry-feature-3-image87d4.jpg"--%> alt="grid-theme-light" style="height: auto; width: 100%; margin-top: -10%; object-fit: cover;" />
                    </figure>
                </a>
            </article>
            <article class="masonry-feature feature-2 color-black enable-mobile-false has-link" data-url="#" <%--style="top: -99.826px;"--%>>
                <a class="" data-bind="attr: { href: '/?ProductId=' + top4ProductsdataList[2].ProductID }">
                    <figure class="no-image figure" style="padding-bottom: 97.048%;">
                        <img data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[2].PhotoIds[1] }" <%--src="../../assets/masonry-feature-4-image87d4.jpg"--%> alt="grid-theme-light" style="height: auto; width: 100%; margin-left: 0; object-fit: cover;" />
                    </figure>
                </a>
            </article>
            <article class="masonry-feature feature-5 color-black enable-mobile-false has-link" data-url="#" style="padding-bottom: 28%;">
                <figure class="no-image" style="padding-bottom: 97.048%;">
                    <a href="#">
                        <img src="../../assets/masonry-feature-5-image87d4.jpg" alt="Free shipping on orders over $100" style="height: auto; width: 100%; margin-top: 0; object-fit: cover;" />
                    </a>
                </figure>
                <div class="masonry-feature-text" style="margin-top: -5%; margin-left: -43%;">
                    <p class="masonry-feature-title">
                        <a href="#">Free shipping on orders over $100</a>
                    </p>
                </div>
            </article>
            <article class="masonry-feature feature-6 color-black enable-mobile-true has-link" data-url="#" style="padding-bottom: 28%;">
                <a class="" data-bind="attr: { href: '/?ProductId=' + top4ProductsdataList[3].ProductID }">
                    <figure class="no-image" style="padding-bottom: 97.048%;">
                        <img data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + top4ProductsdataList[3].PhotoIds[1] }" <%--src="../../assets/masonry-feature-6-image87d4.jpg" alt="grid-theme-light"--%> style="height: auto; width: 100%; margin-left: 0; object-fit: cover;" />
                    </figure>
                </a>
            </article>
        </section>
    </div>
</section>
