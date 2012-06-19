/* Let's test javascript communicating back to the objective-c. */
$(function () {
   
  $('body').append('<div class="container-fluid view">');
  $('body').append('<div class="row-fluid">');
  
  $('body').append('<div class="span12">');
  
  $('body').append('<p><a class="btn btn-primary btn-large" href="ios-callback:test?say=hello">Click me to say hello.</a></p>');
  
  $('body').append('</div>');
  
  $('body').append('<div class="row-fluid">' +
                        '<div class="span6">Col 1</div>' +
                        '<div class="span6">Col 2</div>' +
                   '</div></div>');
  
  $('body').append('</div>');
  
  var $f = new MobileFramework($('body'));
});