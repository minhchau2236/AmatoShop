<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="PSCPortal.Portlets.SecondProducts.Display" %>

<div class="main-content">
    <section class="featured-collections row-of-2" id="secondProducts">
        <div class="featured-collections-list">
            <!-- ko foreach: dataList -->
            <article class="featured-collection first">
                <figure class="featured-collection-image" style="height: 385px;">
                    <img alt="Large Bowls" data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + $data.PhotoIds[1] }" />
                    <a data-bind="attr: { href: '/?ProductId=' + ProductID }" href="collections/large-bowls.html">
                        <div class="featured-collection-overlay-wrapper color-black">
                            <div class="featured-collection-overlay">
                                <h3 class="featured-collection-title" data-bind="html: ProductName"></h3>
                            </div>
                        </div>
                    </a>
                </figure>
                <div class="featured-collection-description" data-bind="html: Specifications" style="min-height: 280px;">
                </div>
            </article>
            <!-- /ko -->
        </div>
    </section>
</div>

<script type="text/javascript">
    var spViewModel = function () {
        var self = this;
        self.dataList = pscjq.parseJSON('<%#DataListProducts%>');
    }
    var spVM = null;
    pscjq(document).ready(
        function () {
            spVM = new spViewModel();
            ko.applyBindings(spVM, $("#secondProducts")[0]);
        });


</script>
