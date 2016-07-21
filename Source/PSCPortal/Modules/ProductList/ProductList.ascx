<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductList.ascx.cs" Inherits="PSCPortal.Modules.ProductList.ProductList" %>

<link href="../../Libs/simpleboostrappagination/simpleboostrappagination_bootstrap.min.css" rel="stylesheet" />
<script src="../../Libs/simpleboostrappagination/simpleboostrappagination_bootstrap.min.js"></script>
<script src="../../Libs/simpleboostrappagination/simpleboostrappagination_jquery.min.js"></script>
<script src="../../Libs/simpleboostrappagination/simple-bootstrap-paginator.min.js"></script>

<script type="text/javascript">
    var viewModel = function () {
        var self = this;
        self.dataList = ko.observableArray([]);
        self.CollectionId = '<%=this.Request.QueryString["CollectionId"]%>';
        self.PageIdx = '<%=this.Request.QueryString["Page"]%>';

        self.CollectionId = 'BS_HNP';

        $.ajax({
            url: "/Services/AmatoService.asmx/GetAllProducts",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var data = $.parseJSON(result.d);
                var pages = Math.ceil(data.count / 3);
                var pag = $('#divpagination').simplePaginator({

                    totalPages: pages,
                    maxButtonsVisible: 3,
                    currentPage: 1,

                    nextLabel: 'Next',
                    prevLabel: 'Prev',
                    firstLabel: 'First',
                    lastLabel: 'Last',

                    pageChange: function (page) {
                        self.PageIdx = page;
                        $.ajax({
                            url: "/Services/AmatoService.asmx/GetProductListInfo",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: JSON.stringify({ collId: self.CollectionId, pageSize: "3", pageIdx: page }),
                            success: function (result) {
                                var data = $.parseJSON(result.d);
                                self.dataList(data);
                            }
                        });
                    }
                });
            }
        });

        $.ajax({
            url: "/Services/AmatoService.asmx/GetProductListInfo",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ collId: self.CollectionId, pageSize: "3", pageIdx: self.PageIdx }),
            success: function (result) {
                var data = $.parseJSON(result.d);
                self.dataList(data);
            }
        });
    }
    var vm = null;
    pscjq(document).ready(function () {
        vm = new viewModel();
        ko.applyBindings(vm, $("#divProductList")[0]);
    });
</script>

<div id="divProductList">
    <div class="main-content">
        <h1 class="page-title">Products</h1>

        <div class="breadcrumbs">
            <a href="/">Home</a> <span class="divider">/</span>
            <a href="/collections">Collections</a> <span class="divider">/</span> <span>Products</span>
        </div>

        <div class="collection">
            <div class="collection-products rows-of-3">
                <!-- ko foreach: dataList -->
                <article class="product-list-item" id="product-list-item-1206794373" data-product-id="1206794373">
                    <a data-bind="attr: { href: '/?ProductId=' + ProductId }">
                        <div class="product-list-item-thumbnail " style="">
                            <img alt="" style="width: 240px;" data-bind="attr: { src: 'services/GetProductImage.ashx?Id=' + PhotoIds[0] }" />
                        </div>
                    </a>
                    <div class="product-list-item-details">
                        <a data-bind="attr: { href: '/?ProductId=' + ProductId }">
                            <p class="product-list-item-vendor" data-bind="text: ProductCode"></p>
                            <h2 class="product-list-item-title" data-bind="text: ProductName"></h2>
                        </a>
                        <p class="product-list-item-price">
                            <span class="money" data-bind="text: ProductPrice"></span>
                        </p>
                    </div>
                </article>
                <!-- /ko -->
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div id="divpagination" class="text-center"></div>
            </div>
        </div>

        <%--<ul class="pagination">
            <li class="active"><a href="#" title="">1</a></li>
            <li><a href="#" title="">2</a></li>
            <li class="next"><a href="#">&#xe600;</a></li>
        </ul>--%>
    </div>
</div>
