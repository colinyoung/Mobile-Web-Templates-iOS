/* Let's test javascript communicating back to the objective-c. */
var $f = null;

$(function () {  
  /* Intentionally global.
     I'm sure there's some better way to put vars in global scope. */
  $f = new MobileFramework($('body'));
  $f.callback("mwt:documentReady");
});