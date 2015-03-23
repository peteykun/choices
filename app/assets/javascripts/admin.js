//= require jquery
//= require jquery_ujs
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales

$(document).ready(function(){

  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });

});
