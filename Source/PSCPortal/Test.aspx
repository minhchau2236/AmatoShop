<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="PSCPortal.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Template</title>
    <!-- Theme CSS -->
    <link href="assets/css/theme.scss87d4.css" rel="stylesheet" type="text/css" media="all" />
    <!-- Third Party JS Libraries -->
    <script src="assets/js/modernizr-2.8.2.min87d4.js" type="text/javascript"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <div class="main-header" role="banner">
        <div class="header-tools-wrapper">
            <div class="header-tools">
                <div class="aligned-left">
                    <p class="navigation-toggle"><span class="navigation-toggle-icon">Open menu</span> <span class="navigation-toggle-text">Menu</span></p>
                    <div class="currency-wrapper">
                        <p class="select-currency">Select language</p>
                        <div class="select-wrapper currency-switcher">
                            <span class="selected-currency"></span>
                            <select id="currencies" name="currencies">
                                <option value="ENG" selected="selected">English</option>
                                <option value="VIE">Tiếng Việt</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="aligned-right">
                    <div class="mini-cart-wrapper">
                        <a class="cart-count" href="cart.html"><span class="cart-count-text">Cart</span> (<span class="cart-count-number">0</span>)</a>
                    </div>
                    <a class="checkout-link" href="#">Checkout</a>
                    <form class="search-form" action="#" method="get">
                        <input class="search-input" name="q" type="text" placeholder="Search" value="" />
                        <input type="submit" value="&#xe606;" />
                    </form>
                </div>
            </div>
        </div>
        <div class="branding">
            <h3 class="slide-title" style="font-family: Karla,Helvetica;">FAMILIA NOTA</h3>
        </div>
    </div>
</body>
</html>
