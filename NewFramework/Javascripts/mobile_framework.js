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
    var _this = this;
    var rootElement = $(html);
    var elements = [];
    if (rootElement.hasClass(this.prefix)) {
      elements.push(rootElement);
    }
    elements.concat(rootElement.find('.' + this.prefix));
    
    $(elements).each(function(i,v) {
      var id = $(v).attr('id');
      var klass = _this.prefix + '-' + id;
      var repeat = $(v);
      if ($('.' + klass).length > 0) return; // Already in the view
      
      // Change ID to a serial one
      repeat.attr('id', id + '-' + i);
      
      // Change previous ID to a namespaced class
      repeat.addClass(klass);
      
      $('body').append(repeat);
    });
  }
};

/* Data updater for elements */

// Repeats relevant number of times
$.fn.populateWithData = function(array) {
  var localObject = $(this[0]).clone();
  var parent = $(this).parent();
  $(this).empty();
  var html = localObject.html();
  $(array).each(function(i,data) {
    var s = Mustache.render(html, data);
    parent.append(s);
  });
}

// Just updates this one element
$.fn.updateWithData = function(data) {
  // @todo
}

// update innerText
$.fn.updateText = function(text) {
  $(this).text(text);
}

/* View: Handles generation of cross-platform view elements. */
var View = function() {};

View.prototype.toString = function() {
  var s = Mustache.render('<div class="{{classes}}" id="view-{{timestamp}}">asdf</div>', {
    classes: "view",
    timestamp: (new Date()).getUTCMilliseconds().toString()
  });
  
  return s;
}

