// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery-2.2.0.min
//= require bootstrap
//= require jquery.validate.js
//= require bootstrap-formhelpers.js
//= require_self

if (typeof jQuery !== 'undefined') {
    (function($) {
        $(document).ajaxStart(function() {
            $('#spinner').fadeIn();
        }).ajaxStop(function() {
            $('#spinner').fadeOut();
        });
    })(jQuery);
}

// generate a random colour for the beta button.	
//get the button. 
$(document).ready(function()
{
    var colours = ["#BFB044","#90BF44","#44BF59","#44BFA8","#4497BF","#446ABF","#4448BF","#7944BF","#B244BF","#BF4460"];

    $("#beta-button").css("background-color",colours[Math.floor(Math.random()*colours.length)]);	
    function doColourChanges()
    {
            $("#beta-button").css("background-color",colours[Math.floor(Math.random()*colours.length)]);	
            setTimeout(doColourChanges, 3000);
    }

    setTimeout(doColourChanges, 3000);	
});
