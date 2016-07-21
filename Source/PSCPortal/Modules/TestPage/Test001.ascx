<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Test001.ascx.cs" Inherits="PSCPortal.Modules.TestPage.Test001" %>

<div class="main-header" role="banner">
    <div class="header-tools-wrapper" style="padding-top: 50px; margin-top: -73px !important;">
        <div class="header-tools">
            <div class="aligned-left">
                <p class="navigation-toggle"><span class="navigation-toggle-icon">Open menu</span> <span class="navigation-toggle-text">Menu</span></p>
                <div class="currency-wrapper">
                    <p class="select-currency">Select language</p>
                    <div class="select-wrapper currency-switcher">
                        <span id="currencyLan" class="selected-currency">ENG</span>
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
                <div style="position: absolute; right: 0px; margin: 23px 0px 0px;">
                    <form class="search-form" action="#" method="get" style="font-size: 14px;">
                        <input class="search-input" name="q" type="text" placeholder="Search" style="width: 186px;" />
                        <input type="submit" value="" style="position: absolute; top: 0px; right: 0px; height: 100%; margin: 0px; padding: 0px 12px; color: #222222; outline: 0px; font-size: 16px; line-height: 1; background: transparent;" />
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="branding">
        <h3 class="slide-title" style="font-family: karla, helvetica;">FAMILIA NOTA</h3>
    </div>
</div>
<div class="navigation-wrapper">
    <nav class="navigation">
        <div class="branding has-logo">
            <a class="logo mobile-nav-logo has-retina" href="index.html">
                <img class="logo-regular" alt="grid-theme-light" src="assets/logo87d4.png" />
                <img class="logo-retina" alt="grid-theme-light" src="assets/logo-retina87d4.png" />
            </a>
            <a class="logo sticky-logo" href="index.html">
                <img alt="grid-theme-light" src="assets/sticky-header-logo87d4.jpg" /></a>
            <span class="navigation-toggle"></span>
        </div>
        <div style="margin: auto;">
            <ul style="list-style-type: none;">
                <li class="mobile-link" style="display: none;">
                    <form class="search-form" method="get">
                        <input class="search-input" name="q" type="text" placeholder="Search" />
                        <input type="submit" value="" />
                    </form>
                </li>
                <li class="first MenuA"><a data-linklist-trigger="home" href="index.html">Home </a></li>
                <li class="has-mega-nav MenuA" data-mega-nav="true"><a data-linklist-trigger="shop" href="collections/all.html">Shop <span class="enter-linklist"></span></a>
                    <ul class="mobile-mega-nav" data-linklist="shop" style="display: none;">
                        <li><span class="back"><span class="icon"></span> Back to previous</span></li>
                        <li class="has-dropdown">
                            <a data-linklist-trigger="by-collection" href="#">By Collection <span class="enter-linklist"></span></a>
                            <ul data-linklist="by-collection">
                                <li><span class="back"><span class="icon"></span> Back to previous</span> </li>
                                <li><a href="#">Limited Edition</a></li>
                                <li><a href="#">Large Bowls</a> </li>
                                <li><a href="#">Pots &amp; Planters</a></li>
                                <li><a href="#">Serving Sets</a></li>
                            </ul>
                        </li>
                        <li class="has-dropdown">
                            <a data-linklist-trigger="small-things" href="#">Small Things <span class="enter-linklist"></span></a>
                            <ul data-linklist="small-things">
                                <li><span class="back"><span class="icon"></span> Back to previous</span> </li>
                                <li><a href="#">Orbit, Mini Bowls</a></li>
                                <li><a href="#">Neon Planters</a></li>
                                <li><a href="#">Warm Wishes Bowls</a></li>
                                <li><a href="#">Mini Planters</a></li>
                                <li><a href="#">Treasure Pot</a></li>
                            </ul>
                        </li>
                        <li class="has-dropdown">
                            <a data-linklist-trigger="big-things" href="#">Big Things <span class="enter-linklist"></span></a>
                            <ul data-linklist="big-things">
                                <li><span class="back"><span class="icon"></span> Back to previous</span></li>
                                <li><a href="#">Cherry Wood Bowl</a></li>
                                <li><a href="products/meridian-bowl.html">Meridian Bowl</a></li>
                                <li><a href="products/walnut-salad-set.html">Walnut Salad Set</a></li>
                                <li><a href="products/nesting-bowls.html">Nesting Bowls</a></li>
                                <li><a href="products/winter-moon.html">Winter Moon</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="MenuA"><a data-linklist-trigger="blog" href="#">Journal </a></li>
                <li class="MenuA"><a data-linklist-trigger="about-us" href="about-us.html">Our Story </a></li>
                <li class="last MenuA"><a data-linklist-trigger="theme-features" href="contact-us.html">Contact Us </a></li>
            </ul>
        </div>
        <a class="cart-count" href="#" style="display: none;"><span class="cart-count-text">Cart</span> (<span class="cart-count-number">0</span>)</a>
    </nav>
</div>
