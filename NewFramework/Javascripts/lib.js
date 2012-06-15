var MobileFramework = function (element) {
  this.prefix = "ios-callback";
  this.element = element || $('body');
    
  this.interceptAllLinks();
};

MobileFramework.prototype = {
  interceptAllLinks: function() {
    var _this = this;
    
    var s = '*[href*="' + this.prefix + '"]';
    $(s).each(function(i, el) {
      var href = $(el).attr('href');
      $(el).attr('href', 'javascript:;'); // unset and replace w/ event listener
      $(el).click(function() {
        _this.callback(href);
      });
    })
  },
  upstream: function() {
    
  },
  callback: function(href) {    
    var iframe = document.createElement("IFRAME");
    iframe.setAttribute("src", href);
    document.documentElement.appendChild(iframe);
    iframe.parentNode.removeChild(iframe);
    iframe = null;
  }
};