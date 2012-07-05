/* Let's test javascript communicating back to the objective-c. */
$(function () {
  
  $('body').append('<a href="mwt:loadHTML">Load HTML</a>');
  
  var $f = new MobileFramework($('body'));
});