(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.MiniCartView = (function(superClass) {
    extend(MiniCartView, superClass);

    function MiniCartView() {
      return MiniCartView.__super__.constructor.apply(this, arguments);
    }

    MiniCartView.prototype.events = {
      "click .mini-cart-item-remove": "removeProduct"
    };

    MiniCartView.prototype.initialize = function() {
      return this.transitionend = (function(transition) {
        var transEndEventNames;
        transEndEventNames = {
          "-webkit-transition": "webkitTransitionEnd",
          "-moz-transition": "transitionend",
          "-o-transition": "oTransitionEnd",
          transition: "transitionend"
        };
        return transEndEventNames[transition];
      })(Modernizr.prefixed("transition"));
    };

    MiniCartView.prototype.removeProduct = function(e) {
      var item, itemRemoved, itemTitle, itemURL, variant;
      item = this.$(e.target).parent(".mini-cart-item");
      variant = item.data("variant");
      itemTitle = item.data("title");
      itemURL = item.data("url");
      itemRemoved = Theme.itemRemovedFromCart.replace("{{ item_title }}", "<a href='" + itemURL + "'>" + itemTitle + "</a>");
      return Shopify.removeItem(variant, (function(_this) {
        return function(cart) {
          if (Modernizr.csstransitions) {
            item.addClass("removing").one(_this.transitionend, function() {
              item.html("<span>" + itemRemoved + "</span>");
              return item.removeClass("removing").addClass("removed");
            });
          } else {
            item.html("<span>" + itemRemoved + "</span>").addClass("removed");
          }
          return _this.updateCart(cart);
        };
      })(this));
    };

    MiniCartView.prototype.updateCart = function(cart) {
      return $(".cart-count").html("<span class='cart-count-text'>" + Theme.cartText + "</span> (<span class='cart-count-number'>" + cart.item_count + "</span>)");
    };

    return MiniCartView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.HeaderView = (function(superClass) {
    extend(HeaderView, superClass);

    function HeaderView() {
      return HeaderView.__super__.constructor.apply(this, arguments);
    }

    HeaderView.prototype.events = {};

    HeaderView.prototype.initialize = function() {
      new MiniCartView({
        el: this.$(".mini-cart")
      });
      this.body = $(document.body);
      this.window = $(window);
      this.branding = this.$(".branding");
      this.headerTools = this.$(".header-tools");
      this.window.resize((function(_this) {
        return function() {
          ;
          _this.fixWonkyLogo();
          ;
          return _this.setSearchWidth();
        };
      })(this)).trigger("resize");
      ;
      this.window.on("scroll", (function(_this) {
        return function() {
          if (document.documentElement.offsetWidth > 1020) {
            if (!_this.body.hasClass("alternate-index-layout")) {
              return _this.triggerStickyHeader();
            }
          }
        };
      })(this));
      this.window.resize((function(_this) {
        return function() {
          if (document.documentElement.offsetWidth <= 1020 && !theme.ltIE9) {
            return _this.body.removeClass("sticky-header");
          }
        };
      })(this));
      return ;
    };

    HeaderView.prototype.setSearchWidth = function() {
      var searchWidth;
      searchWidth = this.$(".mini-cart-wrapper").outerWidth() + this.$(".checkout-link").outerWidth();
      this.$(".search-form").width(searchWidth);
      return this.setLogoPadding(searchWidth);
    };

    HeaderView.prototype.setLogoPadding = function(padding) {
      return this.branding.css({
        "paddingLeft": padding + 60,
        "paddingRight": padding + 60
      });
    };

    ;

    HeaderView.prototype.triggerStickyHeader = function() {
      var branding, cartCount, headerHeight;
      headerHeight = this.$el.outerHeight();
      if (this.window.scrollTop() > headerHeight) {
        this.body.addClass("sticky-header");
      } else {
        this.body.removeClass("sticky-header");
      }
      if (!Modernizr.csstransforms) {
        cartCount = $(".sticky-header .navigation .cart-count");
        cartCount.css({
          "marginTop": -(cartCount.height() / 2)
        });
        branding = $(".sticky-header .navigation .branding");
        return branding.css({
          "marginTop": -(branding.height() / 2)
        });
      }
    };

    ;

    HeaderView.prototype.fixWonkyLogo = function() {
      var branding, logo, logoHeight;
      if (theme.ltIE9) {
        return;
      }
      logoHeight = parseInt("105");
      if (this.body.hasClass("alternate-index-layout")) {
        branding = this.body;
        logo = $(".logo-regular");
      } else {
        branding = this.$(".branding");
        logo = this.$(".logo-retina").is(":visible") ? this.$(".logo-retina") : this.$(".logo-regular");
      }
      return branding.imagesLoaded((function(_this) {
        return function() {
          var initialAspectRatio, newAspectRatio;
          initialAspectRatio = logo[0].naturalWidth / logo[0].naturalHeight;
          initialAspectRatio = Math.round(initialAspectRatio * 10) / 10;
          newAspectRatio = logo[0].width / logoHeight;
          newAspectRatio = Math.round(newAspectRatio * 10) / 10;
          if ((newAspectRatio !== initialAspectRatio) && (logo[0].height <= logoHeight)) {
            return logo.css({
              height: "auto"
            });
          } else {
            return logo.css({
              height: logoHeight
            });
          }
        };
      })(this));
    };

    return HeaderView;

  })(Backbone.View);

}).call(this);

(function() {
  ;
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.CurrencyView = (function(superClass) {
    extend(CurrencyView, superClass);

    function CurrencyView() {
      return CurrencyView.__super__.constructor.apply(this, arguments);
    }

    CurrencyView.prototype.events = {
      "change [name=currencies]": "convertAll",
      "reset-currency": "resetCurrency"
    };

    CurrencyView.prototype.initialize = function() {
      Currency.format = Theme.currencySwitcherFormat;
      Currency.money_with_currency_format = {};
      Currency.money_with_currency_format[Theme.currency] = Theme.moneyFormatCurrency;
      Currency.money_format = {};
      Currency.money_format[Theme.currency] = Theme.moneyFormat;
      this.cookieCurrency = Currency.cookie.read();
      if (this.cookieCurrency) {
        this.$("[name=currencies]").val(this.cookieCurrency);
      }
      $(window).load((function(_this) {
        return function() {
          var doubleMoney, i, j, len, len1, money, ref, ref1;
          ref = $("span.money span.money");
          for (i = 0, len = ref.length; i < len; i++) {
            doubleMoney = ref[i];
            $(doubleMoney).parents("span.money").removeClass("money");
          }
          ref1 = $("span.money");
          for (j = 0, len1 = ref1.length; j < len1; j++) {
            money = ref1[j];
            $(money).data("currency-" + Theme.currency, $(money).html());
          }
          _this.switchCurrency();
          return _this.$(".selected-currency").text(Currency.currentCurrency);
        };
      })(this));
      return $(window).resize((function(_this) {
        return function() {
          if (document.documentElement.offsetWidth <= 1020) {
            return _this.moveCurrencyConverter("mobile");
          } else {
            return _this.moveCurrencyConverter();
          }
        };
      })(this)).trigger("resize");
    };

    CurrencyView.prototype.resetCurrency = function() {
      return Currency.convertAll(Theme.currency, this.$("[name=currencies]").val());
    };

    CurrencyView.prototype.switchCurrency = function() {
      if (this.cookieCurrency === null) {
        return Currency.currentCurrency = Theme.currency;
      } else if (this.$("[name=currencies]").size() && this.$("[name=currencies] option[value=" + this.cookieCurrency + "]").size() === 0) {
        Currency.currentCurrency = Theme.currency;
        return Currency.cookie.write(Theme.currency);
      } else if (this.cookieCurrency === Theme.currency) {
        return Currency.currentCurrency = Theme.currency;
      } else {
        return Currency.convertAll(Theme.currency, this.cookieCurrency);
      }
    };

    CurrencyView.prototype.convertAll = function(e, variant, selector) {
      var newCurrency;
      newCurrency = $(e.target).val();
      Currency.convertAll(Currency.currentCurrency, newCurrency);
      this.$(".selected-currency").text(Currency.currentCurrency);
      return this.cookieCurrency = newCurrency;
    };

    CurrencyView.prototype.moveCurrencyConverter = function(layout) {
      if (layout === "mobile") {
        return $(".currency-wrapper").insertBefore(".sub-footer").addClass("in-footer");
      } else {
        return $(".currency-wrapper").removeClass("in-footer").insertAfter(".main-header .navigation-toggle");
      }
    };

    return CurrencyView;

  })(Backbone.View);

  ;

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.NavigationView = (function(superClass) {
    extend(NavigationView, superClass);

    function NavigationView() {
      return NavigationView.__super__.constructor.apply(this, arguments);
    }

    NavigationView.prototype.events = {
      "mouseover .mega-nav-list a": "swapMegaNavImages",
      "click .has-dropdown .enter-linklist": "enterMegaNavTier",
      "click .has-dropdown .back": "exitMegaNavTier",
      "mouseleave .has-mega-nav": "useDefaultImage"
    };

    NavigationView.prototype.initialize = function() {
      this.body = $(document.body);
      $(".navigation-toggle").on("click", (function(_this) {
        return function() {
          if (_this.body.hasClass("mobile-nav-open")) {
            return _this.toggleMobileNavigation("close");
          } else {
            return _this.toggleMobileNavigation("open");
          }
        };
      })(this));
      this.transitionend = (function(transition) {
        var transEndEventNames;
        transEndEventNames = {
          "-webkit-transition": "webkitTransitionEnd",
          "-moz-transition": "transitionend",
          "-o-transition": "oTransitionEnd",
          transition: "transitionend"
        };
        return transEndEventNames[transition];
      })(Modernizr.prefixed("transition"));
      return $(window).resize((function(_this) {
        return function() {
          _this.setupNavigation();
          if (document.documentElement.offsetWidth > 1020 && _this.body.hasClass("mobile-nav-open")) {
            $(".navigation-wrapper").removeClass("visible");
            _this.toggleMobileNavigation("close");
          }
          if (!Modernizr.csstransforms) {
            return _this.positionMegaNav();
          }
        };
      })(this)).trigger("resize");
    };

    NavigationView.prototype.setupNavigation = function() {
      if (document.documentElement.offsetWidth > 1020 || theme.ltIE9) {
        this.$el.removeClass("mobile").addClass("full-width");
        return this.$("li[data-mega-nav='true']").removeClass("has-dropdown").addClass("has-mega-nav");
      } else {
        this.$el.removeClass("full-width").addClass("mobile");
        return this.$("li[data-mega-nav='true']").removeClass("has-mega-nav").addClass("has-dropdown");
      }
    };

    NavigationView.prototype.swapMegaNavImages = function(e) {
      var image, imageAlt;
      image = this.$(e.target).parent().data("image-src");
      imageAlt = this.$(e.target).parent().data("image-alt");
      return this.$(".mega-nav-image img").attr("src", image).attr("alt", imageAlt);
    };

    NavigationView.prototype.positionMegaNav = function() {
      var megaNav, megaNavWidth;
      megaNav = this.$(".mega-nav");
      megaNavWidth = megaNav.outerWidth();
      return megaNav.css({
        "marginLeft": -(megaNavWidth / 2)
      });
    };

    NavigationView.prototype.toggleMobileNavigation = function(direction) {
      var navigationWrapper;
      navigationWrapper = $(".navigation-wrapper");
      if (direction === "open") {
        this.body.addClass("mobile-nav-open lock-scroll");
        this.$el.addClass("visible");
        navigationWrapper.addClass("visible background");
        this.$("> ul").addClass("in-view active");
        return this.setTierHeight();
      } else if (direction === "close") {
        this.$el.removeAttr("style");
        this.body.removeClass("mobile-nav-open");
        this.$el.removeClass("visible");
        if (Modernizr.csstransitions) {
          return navigationWrapper.removeClass("background").one(this.transitionend, (function(_this) {
            return function() {
              navigationWrapper.removeClass("visible");
              return _this.body.removeClass("lock-scroll");
            };
          })(this));
        } else {
          navigationWrapper.removeClass("background");
          navigationWrapper.removeClass("visible");
          return this.body.removeClass("lock-scroll");
        }
      }
    };

    NavigationView.prototype.enterMegaNavTier = function(e) {
      var targetLinklist;
      if (this.$el.hasClass("mobile")) {
        e.preventDefault();
      }
      targetLinklist = $(e.target).parent().data("linklist-trigger");
      this.$("ul").removeClass("active");
      this.$("ul[data-linklist='" + targetLinklist + "']").addClass("in-view active");
      this.$(e.target).closest("ul").addClass("out-of-view");
      return this.setTierHeight();
    };

    NavigationView.prototype.exitMegaNavTier = function(e) {
      var target;
      target = $(e.target);
      this.$("ul").removeClass("active");
      if (Modernizr.csstransitions) {
        target.closest("ul.out-of-view").removeClass("out-of-view").addClass("active").one(this.transitionend, (function(_this) {
          return function() {
            return target.closest("ul").removeClass("in-view");
          };
        })(this));
      } else {
        target.closest("ul.out-of-view").removeClass("out-of-view").addClass("active");
        target.closest("ul").removeClass("in-view");
      }
      return this.setTierHeight();
    };

    NavigationView.prototype.setTierHeight = function() {
      var brandingHeight, tierHeight, windowHeight;
      this.$el.scrollTop(0);
      windowHeight = window.innerHeight;
      brandingHeight = this.$(".branding").outerHeight();
      tierHeight = this.$("ul.active").outerHeight();
      if (windowHeight > tierHeight + brandingHeight) {
        return this.$el.css({
          "overflow-y": "hidden",
          "max-height": windowHeight,
          "height": "100%"
        });
      } else {
        return this.$el.css({
          "overflow-y": "scroll",
          "max-height": tierHeight + brandingHeight,
          "height": "100%"
        });
      }
    };

    NavigationView.prototype.useDefaultImage = function() {
      var megaNavImage;
      megaNavImage = this.$(".mega-nav-image img");
      return megaNavImage.attr("src", megaNavImage.data("image")).attr("alt", megaNavImage.data("alt"));
    };

    return NavigationView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.FooterView = (function(superClass) {
    extend(FooterView, superClass);

    function FooterView() {
      return FooterView.__super__.constructor.apply(this, arguments);
    }

    FooterView.prototype.events = {};

    FooterView.prototype.initialize = function() {
      return $(window).resize((function(_this) {
        return function() {
          if (document.documentElement.offsetWidth <= 1020) {
            return _this.setupFooter("mobile");
          } else {
            return _this.setupFooter();
          }
        };
      })(this)).trigger("resize");
    };

    FooterView.prototype.setupFooter = function(layout) {
      if (layout === "mobile") {
        return this.$(".mailing-list").prependTo(".upper-footer");
      } else {
        return this.$(".mailing-list").appendTo(".upper-footer");
      }
    };

    return FooterView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.AccountView = (function(superClass) {
    extend(AccountView, superClass);

    function AccountView() {
      return AccountView.__super__.constructor.apply(this, arguments);
    }

    AccountView.prototype.events = {
      "click .delete-address": "deleteAddress",
      "click .edit-address": "editAddress",
      "click .add-new-address": "addNewAddress",
      "click .toggle-forgetfulness": "recoverPassword",
      "change .address-country": "updateProvinceSelectText"
    };

    AccountView.prototype.initialize = function() {
      var body;
      body = $(document.body);
      if (body.hasClass("template-customers-addresses")) {
        this.prepareAddresses();
      }
      if (body.hasClass("template-customers-login")) {
        this.checkForReset();
      }
      if (window.location.hash === "#recover") {
        return this.recoverPassword();
      }
    };

    AccountView.prototype.recoverPassword = function() {
      this.$(".recover-password").toggle();
      return this.$(".customer-login").toggle();
    };

    AccountView.prototype.checkForReset = function() {
      if (this.$(".reset-check").data("successful-reset") === true) {
        return this.$(".successful-reset").show();
      }
    };

    AccountView.prototype.prepareAddresses = function() {
      var address, addressID, addresses, i, len, results;
      new Shopify.CountryProvinceSelector("address-country", "address-province", {
        hideElement: "address-province-container"
      });
      addresses = this.$(".customer-address");
      if (addresses.length) {
        results = [];
        for (i = 0, len = addresses.length; i < len; i++) {
          address = addresses[i];
          addressID = $(address).data("address-id");
          results.push(new Shopify.CountryProvinceSelector("address-country-" + addressID, "address-province-" + addressID, {
            hideElement: "address-province-container-" + addressID
          }));
        }
        return results;
      }
    };

    AccountView.prototype.deleteAddress = function(e) {
      var addressID;
      addressID = $(e.target).parents("[data-address-id]").data("address-id");
      return Shopify.CustomerAddress.destroy(addressID);
    };

    AccountView.prototype.editAddress = function(e) {
      var addressID;
      addressID = $(e.target).parents("[data-address-id]").data("address-id");
      this.$(".customer-address").removeClass("editing").find(".edit-address").removeClass("disabled");
      this.$(".customer-address[data-address-id='" + addressID + "']").addClass("editing").find(".edit-address").addClass("disabled");
      this.$(".customer-address-edit-form, .customer-new-address").addClass("hidden");
      return this.$(".customer-address-edit-form[data-address-id='" + addressID + "']").removeClass("hidden");
    };

    AccountView.prototype.addNewAddress = function() {
      this.$(".customer-address").removeClass("editing").find(".edit-address").removeClass("disabled");
      this.$(".customer-address-edit-form").addClass("hidden");
      return this.$(".customer-new-address").removeClass("hidden");
    };

    AccountView.prototype.updateProvinceSelectText = function() {
      return this.$(".address-province").siblings(".selected-text").text("-- " + Theme.pleaseSelectText + " --");
    };

    return AccountView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.BlogView = (function(superClass) {
    extend(BlogView, superClass);

    function BlogView() {
      return BlogView.__super__.constructor.apply(this, arguments);
    }

    BlogView.prototype.events = {
      "change .blog-sidebar select": "filterBlog"
    };

    BlogView.prototype.initialize = function() {
      var template;
      if ($(document.body).hasClass("template-blog")) {
        template = "blog";
      } else {
        template = "article";
      }
      if (!theme.ltIE9) {
        if (document.documentElement.offsetWidth <= 1020) {
          this.positionSidebar(template, "below");
        } else {
          this.positionSidebar(template);
        }
      }
      this.$el.imagesLoaded((function(_this) {
        return function() {
          _this.setupFeaturedImage();
          return _this.setupFullWidthImages();
        };
      })(this));
      return $(window).resize((function(_this) {
        return function() {
          _this.setupFullWidthImages();
          if (!theme.ltIE9) {
            if (document.documentElement.offsetWidth <= 1020) {
              return _this.positionSidebar(template, "below");
            } else {
              _this.positionSidebar(template);
              return _this.setupFeaturedImage("position-only");
            }
          } else {
            return _this.setupFeaturedImage("position-only");
          }
        };
      })(this));
    };

    ;

    BlogView.prototype.setupFeaturedImage = function(setup) {
      var i, image, len, post, ref, results;
      ref = this.$(".blog-post");
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        post = ref[i];
        post = $(post);
        image = post.find("img.highlight").first();
        if (image.length) {
          if (setup === "position-only") {
            results.push(post.find(".blog-post-inner").css({
              "paddingTop": image.height() - 60
            }));
          } else {
            results.push(post.prepend(image).addClass("has-featured-image").find(".blog-post-inner").css({
              "paddingTop": image.height() - 60
            }));
          }
        } else {
          results.push(void 0);
        }
      }
      return results;
    };

    BlogView.prototype.setupFullWidthImages = function() {
      var i, image, len, postContent, postContentMargin, postContentWidth, ref, results;
      postContent = this.$(".post-content");
      postContentWidth = postContent.outerWidth(true);
      postContentMargin = postContent.css("marginLeft");
      ref = this.$("img.full-width");
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        image = ref[i];
        image = $(image);
        results.push(image.css({
          "width": postContentWidth,
          "left": "-" + postContentMargin
        }));
      }
      return results;
    };

    BlogView.prototype.positionSidebar = function(template, position) {
      var sidebar;
      sidebar = this.$(".blog-sidebar");
      switch (template) {
        case "blog":
          if (position === "below") {
            return sidebar.insertAfter(".blog-posts");
          } else {
            return sidebar.insertBefore(".blog-posts");
          }
          break;
        case "article":
          if (position === "below") {
            return sidebar.insertAfter(".blog-post-wrapper");
          } else {
            return sidebar.insertBefore(".blog-post-wrapper");
          }
      }
    };

    return BlogView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.CartView = (function(superClass) {
    extend(CartView, superClass);

    function CartView() {
      return CartView.__super__.constructor.apply(this, arguments);
    }

    CartView.prototype.events = {
      "click .get-rates": "getRates",
      "change .quantity input": "updateQuantity",
      "click .remove": "removeProduct",
      "click .cart-undo": "undoRemoval",
      "change .cart-instructions textarea": "saveSpecialInstructions"
    };

    CartView.prototype.initialize = function() {
      ;
      ;
      ;
    };

    CartView.prototype.saveSpecialInstructions = function() {
      var newNote;
      newNote = $(".cart-instructions textarea").val();
      return Shopify.updateCartNote(newNote, function(cart) {});
    };

    ;

    ;

    ;

    return CartView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.CollectionView = (function(superClass) {
    extend(CollectionView, superClass);

    function CollectionView() {
      return CollectionView.__super__.constructor.apply(this, arguments);
    }

    CollectionView.prototype.events = {
      "change .collection-tags": "filterCollection",
      "change .collection-sorting select": "sortCollection"
    };

    ;

    ;

    return CollectionView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.ProductListItemView = (function(superClass) {
    extend(ProductListItemView, superClass);

    function ProductListItemView() {
      return ProductListItemView.__super__.constructor.apply(this, arguments);
    }

    ProductListItemView.prototype.events = {
      "click .product-list-item-thumbnail": "redirectToProduct",
      "click .quick-shop-modal-trigger": "initializeQuickShop"
    };

    ProductListItemView.prototype.initialize = function() {
      ;
      this.centerProductItemOverlay();
      return ;
    };

    ;

    ProductListItemView.prototype.centerProductItemOverlay = function() {
      ;
      var trigger, triggerHeight, triggerWidth;
      trigger = this.$(".quick-shop-modal-trigger");
      ;
      triggerHeight = trigger.outerHeight();
      triggerWidth = trigger.outerWidth();
      return trigger.css({
        "marginTop": -(triggerHeight / 2),
        "marginLeft": -(triggerWidth / 2)
      });
    };

    ;

    ProductListItemView.prototype.redirectToProduct = function(e) {
      var url;
      url = !$(e.target).hasClass("quick-shop-modal-trigger") ? $(e.target).data("url") : "";
      if (url) {
        return window.location = url;
      }
    };

    ProductListItemView.prototype.initializeQuickShop = function(e) {
      var quickShopWrapper;
      quickShopWrapper = $(".quick-shop-wrapper");
      quickShopWrapper.data("product-handle", $(e.target).data("product-handle")).data("product-id", $(e.target).data("product-id")).data("variant-id", $(e.target).data("variant-id")).data("vendor-url", $(e.target).data("vendor-url"));
      return new QuickShopView({
        el: quickShopWrapper
      });
    };

    return ProductListItemView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.SlideshowView = (function(superClass) {
    extend(SlideshowView, superClass);

    function SlideshowView() {
      return SlideshowView.__super__.constructor.apply(this, arguments);
    }

    SlideshowView.prototype.initialize = function() {
      ;
      this.slideshowNavigation = false;
      ;
      ;
      this.slideshowPagination = false;
      ;
      ;
      this.slideshowAutoplay = false;
      ;
      $(window).resize((function(_this) {
        return function() {
          return _this.setSlideshowHeight();
        };
      })(this)).trigger("resize");
      return this.slideshowIsSetup = false;
    };

    SlideshowView.prototype.setSlideshowHeight = function() {
      var numSlides, slideshow, slideshowHeight;
      slideshow = this.$(".slideshow-slides");
      slideshowHeight = 1000;
      numSlides = slideshow.find(".slideshow-slide").length;
      return slideshow.imagesLoaded((function(_this) {
        return function() {
          var i, image, imageHeight, index, len, ref, results;
          ref = slideshow.find(".slideshow-slide img");
          results = [];
          for (index = i = 0, len = ref.length; i < len; index = ++i) {
            image = ref[index];
            imageHeight = $(image).height();
            if (imageHeight < slideshowHeight) {
              slideshowHeight = imageHeight;
            }
            if (index === numSlides - 1) {
              _this.$(".slide-image-wrapper").css({
                height: slideshowHeight
              });
              if (!_this.slideshowIsSetup) {
                results.push(_this.setupSlideshow());
              } else {
                results.push(void 0);
              }
            } else {
              results.push(void 0);
            }
          }
          return results;
        };
      })(this));
    };

    SlideshowView.prototype.setupSlideshow = function() {
      this.$(".slideshow-slides").flickity({
        imagesLoaded: true,
        autoPlay: this.slideshowAutoplay,
        prevNextButtons: this.slideshowNavigation,
        pageDots: this.slideshowPagination,
        resize: true,
        wrapAround: true
      });
      return this.slideshowIsSetup = true;
    };

    return SlideshowView;

  })(Backbone.View);

}).call(this);

(function() {
  ;
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.InstagramView = (function(superClass) {
    extend(InstagramView, superClass);

    function InstagramView() {
      return InstagramView.__super__.constructor.apply(this, arguments);
    }

    InstagramView.prototype.events = {};

    InstagramView.prototype.initialize = function() {
      this.photoContainer = this.$(".instagram-photos");
      return this.getInstagramImages();
    };

    InstagramView.prototype.getInstagramImages = function() {
      var count, url;
      if (Theme.twitter) {
        count = 3;
      } else {
        count = 6;
      }
      if (Theme.instagramShowTag && Theme.instagramTag.length) {
        url = "https://api.instagram.com/v1/tags/" + Theme.instagramTag + "/media/recent?access_token=" + Theme.instagramAccessToken + "&count=" + count + "&callback=";
      } else {
        url = "https://api.instagram.com/v1/users/self/media/recent?access_token=" + Theme.instagramAccessToken + "&count=" + count + "&callback=";
      }
      return $.ajax({
        type: "GET",
        dataType: "jsonp",
        url: url,
        success: (function(_this) {
          return function(response) {
            var i, len, photo, ref, results;
            if (response.meta.code === 200) {
              ref = response.data;
              results = [];
              for (i = 0, len = ref.length; i < len; i++) {
                photo = ref[i];
                results.push(_this.photoContainer.append("<a class='instagram-photo' target='_blank' href='" + photo.link + "'><img src='" + photo.images.low_resolution.url + "'/></a>"));
              }
              return results;
            } else {
              _this.$el.remove();
              return console.log("Instagram error: " + response.meta.error_message);
            }
          };
        })(this),
        error: (function(_this) {
          return function(response) {
            _this.$el.remove();
            return console.log("Instagram error: " + response.meta.error_message);
          };
        })(this)
      });
    };

    return InstagramView;

  })(Backbone.View);

  ;

}).call(this);

(function() {
  ;
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.TwitterView = (function(superClass) {
    extend(TwitterView, superClass);

    function TwitterView() {
      return TwitterView.__super__.constructor.apply(this, arguments);
    }

    TwitterView.prototype.events = {};

    TwitterView.prototype.initialize = function() {
      this.fetchTweets();
      ;
      this.window = $(window);
      this.window.load((function(_this) {
        return function() {
          return _this.window.resize(function() {
            return _this.setWidgetHeight();
          }).trigger("resize");
        };
      })(this));
      return ;
    };

    TwitterView.prototype.fetchTweets = function() {
      var config;
      config = {
        "id": Theme.twitterId,
        "maxTweets": 1,
        "enableLinks": true,
        "showUser": true,
        "showTime": true,
        "showRetweet": Theme.twitterShowRetweets,
        "customCallback": this.renderTweets,
        "showInteraction": false
      };
      return twitterFetcher.fetch(config);
    };

    TwitterView.prototype.renderTweets = function(tweets) {
      var i, len, timestamp, tweet;
      if (tweets.length) {
        for (i = 0, len = tweets.length; i < len; i++) {
          tweet = tweets[i];
          tweet = $(tweet);
          this.$(".twitter-tweet").append(tweet);
        }
        timestamp = this.$(".timePosted").text().split(" ");
        return this.$(".timePosted").prepend("<span class='twitter-icon'>&#xE036;</span>");
      } else {
        $(".twitter-widget").remove();
        return console.log("No tweets to display. Most probable cause is an incorrectly entered Widget ID.");
      }
    };

    ;

    TwitterView.prototype.setWidgetHeight = function() {
      var instagramWidget;
      instagramWidget = $(".instagram-widget");
      return instagramWidget.imagesLoaded((function(_this) {
        return function() {
          var instagramHeight, tweet, tweetHeight;
          instagramHeight = instagramWidget.find("img").height();
          tweet = _this.$(".twitter-tweet");
          tweetHeight = tweet.height();
          _this.$el.find(".twitter-tweet-wrapper").height(instagramHeight - 12);
          return tweet.css({
            paddingTop: ((instagramHeight - 12) - tweetHeight) / 2
          });
        };
      })(this));
    };

    ;

    return TwitterView;

  })(Backbone.View);

  ;

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.HomeView = (function(superClass) {
    extend(HomeView, superClass);

    function HomeView() {
      return HomeView.__super__.constructor.apply(this, arguments);
    }

    HomeView.prototype.events = {
      "click .alternative-masonry-feature, .masonry-feature": "redirectMasonryFeatures",
      "click .featured-collection-overlay-wrapper": "redirectFeaturedCollection"
    };

    HomeView.prototype.initialize = function() {
      if (Theme.slideshow) {
        new SlideshowView({
          el: this.$(".home-slideshow")
        });
      }
      if (Theme.instagram) {
        new InstagramView({
          el: this.$(".instagram-widget")
        });
      }
      if (Theme.twitter) {
        new TwitterView({
          el: this.$(".twitter-widget")
        });
      }
      ;
      $(window).resize((function(_this) {
        return function() {
          _this.setupFeaturedCollections();
          if (!Modernizr.csstransforms) {
            return _this.centerFeaturedCollectionText();
          }
        };
      })(this)).trigger("resize");
      ;
      ;
      ;
      $(window).resize((function(_this) {
        return function() {
          return _this.positionMasonryFeatureText();
        };
      })(this)).trigger("resize");
      ;
      ;
      this.masonryFeatures = this.$(".masonry-features");
      $(window).resize((function(_this) {
        return function() {
          if (_this.masonryFeatures.hasClass("has-4-features") || _this.masonryFeatures.hasClass("has-5-features") || _this.masonryFeatures.hasClass("has-6-features")) {
            _this.positionMasonryFeatures();
          }
          if (document.documentElement.offsetWidth > 770 && !_this.masonryFeatures.hasClass("has-1-features")) {
            return _this.setMasonryFeatureHeight();
          }
        };
      })(this)).trigger("resize");
      ;
      ;
    };

    ;

    HomeView.prototype.setupFeaturedCollections = function() {
      var collectionHeight, featuredCollectionImage;
      collectionHeight = 10000;
      featuredCollectionImage = this.$(".featured-collection-image img");
      return this.$(".featured-collections-list").imagesLoaded((function(_this) {
        return function() {
          var collectionImage, i, imageHeight, j, len, len1, results;
          for (i = 0, len = featuredCollectionImage.length; i < len; i++) {
            collectionImage = featuredCollectionImage[i];
            if ($(collectionImage).height() < collectionHeight) {
              collectionHeight = $(collectionImage).height();
            }
          }
          _this.$(".featured-collection-image").height(collectionHeight);
          results = [];
          for (j = 0, len1 = featuredCollectionImage.length; j < len1; j++) {
            collectionImage = featuredCollectionImage[j];
            imageHeight = $(collectionImage).height();
            if (imageHeight > collectionHeight) {
              results.push($(collectionImage).css({
                "marginTop": -(imageHeight - collectionHeight) / 2
              }));
            } else {
              results.push(void 0);
            }
          }
          return results;
        };
      })(this));
    };

    HomeView.prototype.centerFeaturedCollectionText = function() {
      var collectionText, i, len, ref, results, textHeight, textWidth;
      ref = this.$(".featured-collection-overlay");
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        collectionText = ref[i];
        collectionText = $(collectionText);
        textHeight = collectionText.height();
        textWidth = collectionText.outerWidth();
        results.push(collectionText.css({
          "marginTop": -(textHeight / 2),
          "marginLeft": -(textWidth / 2)
        }));
      }
      return results;
    };

    HomeView.prototype.redirectFeaturedCollection = function(e) {
      var url;
      url = $(e.target).data("url");
      if (url !== "") {
        return window.location = url;
      }
    };

    ;

    HomeView.prototype.redirectMasonryFeatures = function(e) {
      var url;
      url = $(e.target).closest("article").data("url");
      if (url !== "") {
        return window.location = url;
      }
    };

    ;

    HomeView.prototype.positionMasonryFeatureText = function() {
      var feature, i, len, ref, results, textHeight, textWidth;
      ref = this.$(".masonry-feature-text");
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        feature = ref[i];
        feature = $(feature);
        textHeight = feature.height();
        textWidth = feature.outerWidth();
        results.push(feature.css({
          "marginTop": -(textHeight / 2),
          "marginLeft": -(textWidth / 2)
        }));
      }
      return results;
    };

    ;

    ;

    HomeView.prototype.positionMasonryFeatures = function() {
      var bumpFeature, containerWidth, offset;
      if (this.masonryFeatures.hasClass("has-4-features") || this.masonryFeatures.hasClass("has-5-features")) {
        bumpFeature = this.$(".feature-3");
      } else if (this.masonryFeatures.hasClass("has-6-features")) {
        bumpFeature = this.$(".feature-4");
      }
      containerWidth = this.masonryFeatures.outerWidth();
      offset = -(containerWidth * 0.074);
      bumpFeature.css({
        "top": offset
      });
      return this.masonryFeatures.css({
        "marginBottom": offset
      });
    };

    HomeView.prototype.setMasonryFeatureHeight = function() {
      return this.masonryFeatures.imagesLoaded((function(_this) {
        return function() {
          var feature, featureAspect, height, i, image, imageAspect, len, ref, results, width;
          ref = _this.masonryFeatures.children(".masonry-feature");
          results = [];
          for (i = 0, len = ref.length; i < len; i++) {
            feature = ref[i];
            feature = $(feature);
            height = feature.outerHeight(true);
            width = feature.outerWidth();
            featureAspect = (height / width) * 100;
            feature.children("figure").css({
              "paddingBottom": featureAspect + "%"
            });
            image = feature.find("img");
            image.css({
              "height": "auto",
              "width": "auto"
            });
            imageAspect = (image.height() / image.width()) * 100;
            if (imageAspect < featureAspect) {
              results.push(image.height(feature.children("figure").outerHeight()).css({
                "marginLeft": -((image.width() - width) / 2)
              }));
            } else {
              results.push(image.width(feature.children("figure").outerWidth()).css({
                "marginTop": -((image.height() - height) / 2)
              }));
            }
          }
          return results;
        };
      })(this));
    };

    ;

    ;

    return HomeView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.ListCollectionsView = (function(superClass) {
    extend(ListCollectionsView, superClass);

    function ListCollectionsView() {
      return ListCollectionsView.__super__.constructor.apply(this, arguments);
    }

    ListCollectionsView.prototype.events = {};

    ListCollectionsView.prototype.initialize = function() {};

    return ListCollectionsView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.NotFoundView = (function(superClass) {
    extend(NotFoundView, superClass);

    function NotFoundView() {
      return NotFoundView.__super__.constructor.apply(this, arguments);
    }

    NotFoundView.prototype.events = {};

    NotFoundView.prototype.initialize = function() {};

    return NotFoundView;

  })(Backbone.View);

}).call(this);

(function() {
  ;
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.ImageZoomView = (function(superClass) {
    extend(ImageZoomView, superClass);

    function ImageZoomView() {
      return ImageZoomView.__super__.constructor.apply(this, arguments);
    }

    ImageZoomView.prototype.events = {
      "prepare-zoom": "prepareZoom",
      "click": "toggleZoom",
      "mouseout .product-zoom": "toggleZoom",
      "mousemove .product-zoom": "zoomImage"
    };

    ImageZoomView.prototype.initialize = function() {
      this.zoomArea = this.$(".product-zoom");
      return this.$el.imagesLoaded((function(_this) {
        return function() {
          return _this.prepareZoom();
        };
      })(this));
    };

    ImageZoomView.prototype.prepareZoom = function() {
      var newImage, photoAreaHeight, photoAreaWidth;
      photoAreaWidth = this.$el.width();
      photoAreaHeight = this.$el.height();
      newImage = new Image();
      $(newImage).on("load", (function(_this) {
        return function() {
          var ratio, ratios;
          _this.zoomImageWidth = newImage.width;
          _this.zoomImageHeight = newImage.height;
          ratios = new Array();
          ratios[0] = _this.zoomImageWidth / photoAreaWidth;
          ratios[1] = _this.zoomImageHeight / photoAreaHeight;
          ratio = Math.max.apply(Math, ratios);
          if (ratio < 1.4) {
            _this.$el.removeClass("zoom-enabled");
          } else {
            _this.$el.addClass("zoom-enabled");
            return _this.zoomArea.css({
              backgroundImage: "url(" + newImage.src + ")"
            });
          }
        };
      })(this));
      return newImage.src = this.$("img").attr("src");
    };

    ImageZoomView.prototype.toggleZoom = function(e) {
      if (this.$el.hasClass("zoom-enabled")) {
        if (e.type === "mouseout") {
          this.zoomArea.removeClass("active");
          return;
        }
        this.zoomArea.toggleClass("active");
        return this.zoomImage(e);
      }
    };

    ImageZoomView.prototype.zoomImage = function(e) {
      var bigImageOffset, bigImageX, bigImageY, mousePositionX, mousePositionY, newBackgroundPosition, ratioX, ratioY, zoomHeight, zoomWidth;
      zoomWidth = this.zoomArea.width();
      zoomHeight = this.zoomArea.height();
      bigImageOffset = this.$el.offset();
      bigImageX = Math.round(bigImageOffset.left);
      bigImageY = Math.round(bigImageOffset.top);
      mousePositionX = e.pageX - bigImageX;
      mousePositionY = e.pageY - bigImageY;
      if (mousePositionX < zoomWidth && mousePositionY < zoomHeight && mousePositionX > 0 && mousePositionY > 0) {
        if (this.zoomArea.hasClass("active")) {
          ratioX = Math.round(mousePositionX / zoomWidth * this.zoomImageWidth - zoomWidth / 2) * -1;
          ratioY = Math.round(mousePositionY / zoomHeight * this.zoomImageHeight - zoomHeight / 2) * -1;
          if (ratioX > 0) {
            ratioX = 0;
          }
          if (ratioY > 0) {
            ratioY = 0;
          }
          if (ratioX < -(this.zoomImageWidth - zoomWidth)) {
            ratioX = -(this.zoomImageWidth - zoomWidth);
          }
          if (ratioY < -(this.zoomImageHeight - zoomHeight)) {
            ratioY = -(this.zoomImageHeight - zoomHeight);
          }
          newBackgroundPosition = ratioX + "px " + ratioY + "px";
          return this.zoomArea.css({
            backgroundPosition: newBackgroundPosition
          });
        }
      }
    };

    return ImageZoomView;

  })(Backbone.View);

  ;

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.ProductSlideshowView = (function(superClass) {
    extend(ProductSlideshowView, superClass);

    function ProductSlideshowView() {
      return ProductSlideshowView.__super__.constructor.apply(this, arguments);
    }

    ProductSlideshowView.prototype.events = {
      "click .product-thumbnails-navigation-previous, .product-thumbnails-navigation-next": "moveProductThumbnails"
    };

    ProductSlideshowView.prototype.initialize = function() {
      this.isQuickShop = this.$el.parent().hasClass("quick-shop");
      this.productThumbnailsWrapper = this.$(".product-thumbnails-wrapper");
      this.productThumbnails = this.$(".product-thumbnails");
      this.productThumbnail = this.$(".product-thumbnail");
      if (this.$(".product-thumbnails").hasClass("has-side-scroll")) {
        this.setupProductSlideshow();
        return $(window).resize((function(_this) {
          return function() {
            _this.setupProductSlideshow();
            return _this.productThumbnails.css({
              "left": 0
            });
          };
        })(this));
      }
    };

    ProductSlideshowView.prototype.setupProductSlideshow = function() {
      var containerWidth, tallestImageHeight;
      tallestImageHeight = 0;
      containerWidth = 0;
      return this.productThumbnails.imagesLoaded((function(_this) {
        return function() {
          var currentImageHeight, currentImageWidth, i, image, len, ref;
          _this.productThumbnailPadding = parseInt(_this.productThumbnail.css("padding-left"), 10) * 2;
          _this.productThumbnail.width((_this.productThumbnailsWrapper.width() / 4) - _this.productThumbnailPadding);
          ref = _this.productThumbnail;
          for (i = 0, len = ref.length; i < len; i++) {
            image = ref[i];
            image = $(image);
            currentImageHeight = image.outerHeight();
            currentImageWidth = image.outerWidth();
            if (currentImageHeight > tallestImageHeight) {
              tallestImageHeight = currentImageHeight;
            }
            containerWidth += currentImageWidth;
          }
          _this.productThumbnailsWrapper.height(tallestImageHeight);
          return _this.productThumbnails.width(containerWidth);
        };
      })(this));
    };

    ProductSlideshowView.prototype.moveProductThumbnails = function(e) {
      var containerWidth, currentPosition;
      containerWidth = this.productThumbnailsWrapper.width();
      currentPosition = this.productThumbnails.position().left;
      if ($(e.currentTarget).hasClass("product-thumbnails-navigation-next") && (currentPosition - containerWidth) > -(this.$(".product-thumbnails").outerWidth())) {
        return this.productThumbnails.css({
          "left": currentPosition - containerWidth
        });
      } else if ($(e.target).hasClass("product-thumbnails-navigation-previous") && currentPosition < 0) {
        return this.productThumbnails.css({
          "left": currentPosition + containerWidth
        });
      }
    };

    return ProductSlideshowView;

  })(Backbone.View);

}).call(this);

(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.ProductView = (function(superClass) {
    extend(ProductView, superClass);

    function ProductView() {
      this.selectCallback = bind(this.selectCallback, this);
      return ProductView.__super__.constructor.apply(this, arguments);
    }

    ProductView.prototype.events = {
      "click .product-thumbnails img": "swapProductImage",
      "click .add-to-cart input": "addToCart"
    };

    ProductView.prototype.initialize = function() {
      this.transitionend = (function(transition) {
        var transEndEventNames;
        transEndEventNames = {
          "-webkit-transition": "webkitTransitionEnd",
          "-moz-transition": "transitionend",
          "-o-transition": "oTransitionEnd",
          transition: "transitionend"
        };
        return transEndEventNames[transition];
      })(Modernizr.prefixed("transition"));
      this.window = $(window);
      this.isQuickShop = this.$el.hasClass("quick-shop-wrapper");
      this.productId = this.$el.data("product-id");
      this.product = this.isQuickShop ? this.$(".quick-shop").data("item") : window.products[this.productId];
      this.variants = this.product.variants;
      this.images = this.product.images;
      this.minimumPriceArea = this.$(".product-price-minimum");
      this.productImages = this.$el.find(".product-images");
      this.mainImage = this.$(".product-main-image img");
      this.productThumbnail = this.$(".product-thumbnail");
      this.productDetailsWrapper = this.$el.find(".product-details-wrapper");
      this.productDetails = this.$el.find(".product-details");
      this.cacheImages();
      this.setupSelectors();
      ;
      new ProductSlideshowView({
        el: this.productImages
      });
      if (Theme.imageZoom) {
        new ImageZoomView({
          el: this.$(".product-main-image")
        });
      }
      ;
    };

    ;

    ProductView.prototype.switchCurrency = function(minimum, compare) {
      var attribute, i, len, ref;
      ref = this.minimumPriceArea[0].attributes;
      for (i = 0, len = ref.length; i < len; i++) {
        attribute = ref[i];
        if (attribute.name.indexOf("data-") > -1) {
          this.minimumPriceArea.attr(attribute.name, "");
        }
      }
      this.minimumPriceArea.attr("data-currency-" + Currency.currentCurrency, "").attr("data-currency-" + Theme.currency, Shopify.formatMoney(minimum, Theme.moneyFormat)).attr("data-currency", Theme.currency);
      this.$(".product-price-compare").attr("data-currency-" + Theme.currency, Shopify.formatMoney(compare, Theme.moneyFormat)).attr("data-currency", Theme.currency);
      return $('.currency-switcher').trigger("reset-currency");
    };

    ;

    ProductView.prototype.cacheImages = function() {
      return Shopify.Image.preload(this.images, "1024x1024");
    };

    ProductView.prototype.setupSelectors = function() {
      var currentLabelWidth, enableHistory, firstVariant, i, index, j, k, label, labelWidth, labels, len, len1, len2, option, optionSelectors, ref, ref1, variant;
      enableHistory = $(document.body).hasClass("template-product") ? true : false;
      optionSelectors = new Shopify.OptionSelectors("product-variants-" + this.productId, {
        product: this.product,
        onVariantSelected: this.selectCallback,
        enableHistoryState: enableHistory
      });
      firstVariant = this.isQuickShop ? this.$el.data("variant-id") : FirstVariant[this.productId];
      optionSelectors.selectVariant(firstVariant);
      ;
      if (this.variants.length === 1 && this.variants[0].title === "Default Title" || this.variants[0].title === "Default title") {
        this.$el.find(".product-options").addClass("no-options");
      } else if (this.isQuickShop) {
        this.$(".selector-wrapper label").remove();
        ref = this.product.options;
        for (index = i = 0, len = ref.length; i < len; index = ++i) {
          option = ref[index];
          this.$(".selector-wrapper").eq(index).prepend("<label>" + this.product.options[index].name + "</label>");
        }
      } else if (this.product.options.length === 1 && this.product.options[0] !== "Title") {
        this.$(".selector-wrapper").prepend("<label>" + this.product.options[0] + "</label>");
      }
      ref1 = this.variants;
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        variant = ref1[j];
        if (variant.featured_image) {
          this.hasVariantImages = true;
        }
      }
      labels = this.$(".selector-wrapper label");
      labelWidth = 0;
      for (k = 0, len2 = labels.length; k < len2; k++) {
        label = labels[k];
        currentLabelWidth = $(label).width() + 1;
        if (currentLabelWidth > labelWidth) {
          labelWidth = currentLabelWidth;
        }
      }
      return labels.width(labelWidth);
    };

    ProductView.prototype.selectCallback = function(variant, selector) {
      var addToCartButton;
      addToCartButton = this.$(".add-to-cart input");
      this.$(".product-message").empty();
      if (variant) {
        if (variant.available) {
          addToCartButton.val(Theme.addToCartText).removeClass("disabled").prop("disabled", false);
          this.$el.data("variant", variant);
        } else {
          addToCartButton.val(Theme.soldOutText).addClass("disabled").prop("disabled", true);
        }
        this.minimumPriceArea.html(Shopify.formatMoney(variant.price, Theme.moneyFormat));
        this.$(".product-price-compare").remove();
        if (variant.compare_at_price > variant.price) {
          this.minimumPriceArea.after("<span class='product-price-compare money' />");
          this.$(".product-price-compare").html(Shopify.formatMoney(variant.compare_at_price, Theme.moneyFormat));
        }
        if (Theme.currencySwitcher) {
          this.switchCurrency(variant.price, variant.compare_at_price);
        }
        if (this.hasVariantImages) {
          if (variant.featured_image) {
            return this.swapProductImage(null, variant.featured_image.src);
          } else {
            return this.$el.find(".product-main-image img").attr("src", this.product.featured_image);
          }
        }
      } else {
        return addToCartButton.val(Theme.unavailableText).addClass("disabled").prop("disabled", true);
      }
    };

    ProductView.prototype.swapProductImage = function(e, imageSrc) {
      var newImage;
      this.productThumbnail.removeClass("active");
      if (e) {
        this.$(e.currentTarget).parent().addClass("active");
        newImage = this.$(e.currentTarget).data("high-res");
        return this.$(e.currentTarget).closest(this.$el).find(".product-main-image img").attr("src", newImage).trigger("prepare-zoom");
      } else {
        newImage = imageSrc;
        return this.$el.find(".product-main-image img").attr("src", newImage).trigger("prepare-zoom");
      }
    };

    ;

    ;

    return ProductView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.QuickShopView = (function(superClass) {
    extend(QuickShopView, superClass);

    function QuickShopView() {
      return QuickShopView.__super__.constructor.apply(this, arguments);
    }

    QuickShopView.prototype.events = {
      "click": "closeQuickShop"
    };

    QuickShopView.prototype.initialize = function() {
      this.productImages = this.$(".product-images");
      this.mainImage = this.$(".product-main-image");
      this.thumbnailsOuterWrapper = this.$(".product-thumbnails-outer-wrapper");
      this.thumbnailsWrapper = this.thumbnailsOuterWrapper.find(".product-thumbnails-wrapper");
      this.thumbnails = this.$(".product-thumbnails");
      this.productDetails = this.$(".product-details");
      this.quickShop = this.$(".quick-shop");
      Shopify.getProduct(this.$el.data("product-handle"), (function(_this) {
        return function(item) {
          var i, j, len, len1, ref, ref1, results, rte, select;
          $(document.body).addClass("scroll-locked");
          _this.quickShop.data("item", item);
          _this.$el.addClass("visible");
          _this.setupProductDetails(item);
          new ProductView({
            el: _this.$el
          });
          ref = _this.$("select");
          for (i = 0, len = ref.length; i < len; i++) {
            select = ref[i];
            new SelectView({
              el: select
            });
          }
          ref1 = _this.$(".rte");
          results = [];
          for (j = 0, len1 = ref1.length; j < len1; j++) {
            rte = ref1[j];
            results.push(new RTEView({
              el: rte
            }));
          }
          return results;
        };
      })(this));
      return $(window).resize((function(_this) {
        return function() {
          _this.positionQuickShop();
          if (!theme.ltIE9) {
            if (document.documentElement.offsetWidth <= 1020 && $(document.body).hasClass("quick-shop-open")) {
              return _this.closeQuickShop();
            }
          }
        };
      })(this));
    };

    QuickShopView.prototype.closeQuickShop = function(e) {
      if (!this.$(e.target).closest(".quick-shop").length) {
        return this.$el.removeClass("visible").one("trend", (function(_this) {
          return function() {
            $(document.body).removeClass("scroll-locked");
            _this.$el.add(_this.quickShop).removeClass("active");
            _this.mainImage.add(_this.thumbnails).add(_this.productDetails).empty();
            _this.thumbnailsWrapper.add(_this.thumbnails).removeAttr("style");
            _this.thumbnails.removeClass("has-side-scroll");
            return _this.$(".product-thumbnails-navigation").remove();
          };
        })(this));
      }
    };

    QuickShopView.prototype.setupProductDetails = function(item) {
      var addToCartButton, compactImage, description, firstVariant, hasVariantImages, i, image, index, itemCompareAtPrice, itemPrice, j, k, largeImage, len, len1, len2, ref, ref1, ref2, stock, variant, variantPrice, vendor, vendorURL, zoom;
      if (item.images.length > 4) {
        this.thumbnails.addClass("has-side-scroll");
      }
      ref = item.images;
      for (index = i = 0, len = ref.length; i < len; index = ++i) {
        image = ref[index];
        largeImage = Shopify.resizeImage(image, "1024x1024");
        compactImage = Shopify.resizeImage(image, "compact");
        if (item.images.length > 1) {
          this.thumbnails.append("<span class=\"product-thumbnail\" data-image-position=\"" + index + "\">\n    <img data-high-res=\"" + largeImage + "\" src=\"" + compactImage + "\">\n</span>");
        }
      }
      if (item.images.length > 4) {
        this.thumbnailsOuterWrapper.prepend("<span class=\"product-thumbnails-navigation product-thumbnails-navigation-previous\">&#xe601;</span>");
        this.thumbnailsOuterWrapper.append("<span class=\"product-thumbnails-navigation product-thumbnails-navigation-next\">&#xe600;</span>");
      }
      zoom = "";
      ;
      zoom = "<div class='product-zoom'></div>";
      ;
      hasVariantImages = false;
      ref1 = item.variants;
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        variant = ref1[j];
        if (variant.id === $(".quick-shop-wrapper").data("variant-id") && variant.featured_image) {
          hasVariantImages = true;
        }
      }
      if (hasVariantImages) {
        largeImage = Shopify.resizeImage(variant.featured_image, "1024x1024");
      } else {
        largeImage = Shopify.resizeImage(item.featured_image, "1024x1024");
      }
      this.mainImage.prepend("<img class=\"product-image\" src=\"" + largeImage + "\">\n" + zoom);
      vendor = "";
      ;
      vendorURL = this.$el.data("vendor-url");
      vendor = "<a class='product-vendor' href='" + vendorURL + "'>" + item.vendor + "</a>";
      ;
      firstVariant = item.variants[0];
      itemPrice = Shopify.formatMoney(firstVariant.price, Theme.moneyFormat);
      itemCompareAtPrice = "";
      if (firstVariant.compare_at_price > firstVariant.price) {
        itemCompareAtPrice = Shopify.formatMoney(firstVariant.compare_at_price, Theme.moneyFormat);
      }
      stock = "InStock";
      addToCartButton = "<input type='submit' value='Add to cart' />";
      if (!item.available) {
        stock = "OutOfStock";
        addToCartButton = "<input type='submit' class='disabled' disabled='disabled' value='Sold out' />";
      }
      description = "";
      if (item.description !== null) {
        description = "<div class='product-description rte' itemprop='description'>" + item.description + "</div>";
      }
      this.productDetails.append(vendor + "\n\n<h2 class=\"product-title\"></h2>\n\n<p class=\"product-price\" itemprop=\"offers\" itemscope itemtype=\"http://schema.org/Offer\">\n    <span class=\"product-price-minimum money\">" + itemPrice + "</span>\n    <span class=\"product-price-compare money\">" + itemCompareAtPrice + "</span>\n    <link itemprop=\"availability\" href=\"http://schema.org/" + stock + "\">\n</p>\n\n<form action=\"/cart/add\" method=\"post\" id=\"product-form-" + item.id + "\" data-product-id=\"" + item.id + "\">\n\n    <div class=\"product-options\">\n        <select class=\"product-variants\" name=\"id\" id=\"product-variants-" + item.id + "\"></select>\n    </div>\n\n    <div class=\"product-quantity inline-input-wrapper\">\n        <label>Quantity</label>\n        <input type=\"text\" name=\"quantity\" value=\"1\" />\n    </div>\n\n    <div class=\"add-to-cart\">\n        " + addToCartButton + "\n    </div>\n\n    <div class=\"product-message\"></div>\n\n</form>\n\n" + description + "\n\n<a class=\"view-product\" href=\"" + item.url + "\">View product</a>");
      ref2 = item.variants;
      for (k = 0, len2 = ref2.length; k < len2; k++) {
        variant = ref2[k];
        variantPrice = Shopify.formatMoney(variant.price, Theme.moneyFormat);
        this.$(".product-variants").append("<option value='" + variant.id + "'>" + variant.title + " - " + variantPrice + "</option>");
      }
      return this.productImages.imagesLoaded((function(_this) {
        return function() {
          _this.quickShop.addClass("active");
          return _this.positionQuickShop();
        };
      })(this));
    };

    QuickShopView.prototype.positionQuickShop = function() {
      return this.quickShop.css({
        marginTop: -(this.quickShop.outerHeight() / 2),
        marginLeft: -(this.quickShop.outerWidth() / 2)
      });
    };

    return QuickShopView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.RTEView = (function(superClass) {
    extend(RTEView, superClass);

    function RTEView() {
      return RTEView.__super__.constructor.apply(this, arguments);
    }

    RTEView.prototype.events = {
      "click .tabs li": "switchTabs"
    };

    RTEView.prototype.initialize = function() {
      this.setupTabs();
      return this.resizeVideos();
    };

    RTEView.prototype.switchTabs = function(e) {
      var content, position, tab, tabContainer, tabContentContainer;
      e.preventDefault();
      tab = $(e.currentTarget);
      tabContainer = tab.parent();
      tabContentContainer = tabContainer.next();
      position = tab.index();
      content = tabContentContainer.find("> li").eq(position);
      tabContainer.find("> li").removeClass("active");
      tabContentContainer.find("> li").removeClass("active");
      tab.addClass("active");
      return content.addClass("active");
    };

    RTEView.prototype.setupTabs = function() {
      var tabs;
      tabs = this.$el.find(".tabs");
      tabs.find("li:first").addClass("active");
      return tabs.next().find("li:first").addClass("active");
    };

    RTEView.prototype.resizeVideos = function() {
      var i, len, ref, results, video;
      this.$el.fitVids({
        customSelector: "iframe"
      });
      ref = this.$("iframe");
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        video = ref[i];
        video = $(video);
        if (video.hasClass("highlight")) {
          results.push(video.parent().addClass("highlight"));
        } else {
          results.push(void 0);
        }
      }
      return results;
    };

    return RTEView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.SelectView = (function(superClass) {
    extend(SelectView, superClass);

    function SelectView() {
      return SelectView.__super__.constructor.apply(this, arguments);
    }

    SelectView.prototype.events = {
      "change": "updateSelectText"
    };

    SelectView.prototype.initialize = function() {
      if (!(this.$el.parent(".select-wrapper").length || this.$el.hasClass("product-variants"))) {
        this.$el.wrap("<div class='select-wrapper' />").parent().prepend("<span class='selected-text'></span>");
      }
      return this.updateSelectText();
    };

    SelectView.prototype.updateSelectText = function() {
      var newOption;
      newOption = this.$el.find("option:selected").text();
      return this.$el.siblings(".selected-text").text(newOption);
    };

    return SelectView;

  })(Backbone.View);

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.ThemeView = (function(superClass) {
    extend(ThemeView, superClass);

    function ThemeView() {
      return ThemeView.__super__.constructor.apply(this, arguments);
    }

    ThemeView.prototype.el = document.body;

    ThemeView.prototype.initialize = function() {
      var body;
      body = $(document.body);
      this.ltIE9 = $("html").hasClass("lt-ie9");
      this.isHome = body.hasClass("template-index");
      this.isCollection = body.hasClass("template-collection");
      this.isListCollections = body.hasClass("template-list-collections");
      this.isProduct = body.hasClass("template-product");
      this.isCart = body.hasClass("template-cart");
      this.isPage = body.hasClass("template-page");
      this.isBlog = body.hasClass("template-blog") || body.hasClass("template-article");
      this.isAccount = body.attr("class").indexOf("-customers-") > 0;
      this.is404 = body.hasClass("template-404");
      this.isSearch = body.hasClass("template-search");
      if (navigator.userAgent.indexOf("MSIE 10") !== -1) {
        this.$el.addClass("ie10");
      }
      return $(window).load((function(_this) {
        return function() {
          return body.removeClass("loading");
        };
      })(this));
    };

    ThemeView.prototype.render = function() {
      var i, j, k, len, len1, len2, productItem, ref, ref1, ref2, rte, select;
      new HeaderView({
        el: $(".main-header")
      });
      new NavigationView({
        el: $(".navigation")
      });
      new FooterView({
        el: $("footer")
      });
      if (Theme.currencySwitcher) {
        new CurrencyView({
          el: this.$(".currency-switcher")
        });
      }
      if (this.isHome) {
        new HomeView({
          el: this.$el
        });
        if (Theme.quickShop && Theme.featuredProducts) {
          new QuickShopView({
            el: this.$(".featured-products")
          });
        }
      }
      if (this.isCollection) {
        new CollectionView({
          el: this.$(".collection")
        });
        if (Theme.quickShop) {
          new QuickShopView({
            el: this.$(".collection-products")
          });
        }
      }
      if (this.isListCollections) {
        new ListCollectionsView({
          el: $(".collections-list")
        });
      }
      if (this.isProduct) {
        new ProductView({
          el: this.$(".product-wrap")
        });
        if (Theme.quickShop && Theme.relatedProducts) {
          new QuickShopView({
            el: this.$(".related-products")
          });
        }
      }
      if (this.isCart) {
        new CartView({
          el: this.$el
        });
      }
      if (this.isBlog) {
        new BlogView({
          el: this.$el
        });
      }
      if (this.isAccount) {
        new AccountView({
          el: this.$el
        });
      }
      if (this.is404) {
        new NotFoundView({
          el: this.$el
        });
      }
      if (this.isSearch && Theme.quickShop) {
        new QuickShopView({
          el: this.$(".search-results-products")
        });
      }
      ref = $(".rte");
      for (i = 0, len = ref.length; i < len; i++) {
        rte = ref[i];
        new RTEView({
          el: rte
        });
      }
      ref1 = $("select");
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        select = ref1[j];
        new SelectView({
          el: select
        });
      }
      ref2 = $(".product-list-item");
      for (k = 0, len2 = ref2.length; k < len2; k++) {
        productItem = ref2[k];
        new ProductListItemView({
          el: productItem
        });
      }
      if ($("html").hasClass("lt-ie10")) {
        return this.inputPlaceholderFix();
      }
    };

    ThemeView.prototype.inputPlaceholderFix = function() {
      var i, input, len, placeholders, text;
      placeholders = $("[placeholder]");
      for (i = 0, len = placeholders.length; i < len; i++) {
        input = placeholders[i];
        input = $(input);
        if (!(input.val().length > 0)) {
          text = input.attr("placeholder");
          input.attr("value", text);
          input.data("original-text", text);
        }
      }
      placeholders.focus(function() {
        input = $(this);
        if (input.val() === input.data("original-text")) {
          return input.val('');
        }
      });
      return placeholders.blur(function() {
        input = $(this);
        if (input.val().length === 0) {
          return input.val(input.data("original-text"));
        }
      });
    };

    return ThemeView;

  })(Backbone.View);

  $(function() {
    window.theme = new ThemeView();
    return theme.render();
  });

}).call(this);
