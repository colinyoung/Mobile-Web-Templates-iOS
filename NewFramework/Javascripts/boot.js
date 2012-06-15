/* Let's test javascript communicating back to the objective-c. */
$(function () {
  
  var target = $('<p><a href="ios-callback:test" style="font-size: 20pt">Click me to make an alert.</a></p>');
  $('body').append(target);
  
  target = $('<p><a href="ios-callback:test?say=hello" style="font-size: 20pt">Click me to say hello.</a></p>');
  $('body').append(target);
  
  var $f = new MobileFramework($('body'));
});