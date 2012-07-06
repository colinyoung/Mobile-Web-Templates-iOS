var MobileFramework = function (element) {
  this.prefix = "mwt";
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
      $(el).bind('tapone', function() {
        _this.callback(href);
      });
    })
  },
  callback: function(href) {    
    var iframe = document.createElement("IFRAME");
    iframe.setAttribute("src", href);
    document.documentElement.appendChild(iframe);
    iframe.parentNode.removeChild(iframe);
    iframe = null;
  },
  extractTemplatingElements: function(html) {
    var rootElement = $(html);
    var elements = [];
    if (rootElement.hasClass(this.prefix)) {
      elements.push(rootElement);
    }
    elements.concat(rootElement.find('.' + this.prefix));
    
    $(elements).each(function(i,v) {
      var repeat = $(v);
      repeat.css('background-color: rgba(255,0,255,0.4)');
      $('body').append(repeat);
    });
  }
};

/* View: Handles generation of cross-platform view elements. */
var View = function() {};

View.prototype.toString = function() {
  var s = Mustache.render('<div class="{{classes}}" id="view-{{timestamp}}">asdf</div>', {
    classes: "view",
    timestamp: (new Date()).getUTCMilliseconds().toString()
  });
  
  return s;
}

