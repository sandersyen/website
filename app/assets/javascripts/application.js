// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment 
//= require fullcalendar
//= require daterangepicker
//= require js.cookie
//= require jstz
//= require browser_timezone_rails/set_time_zone
var show_search = true;

if($("#event-search-bar").val())(function()
{
    show_search = true;
});

if($("#group-search-bar").val())(function()
{
    show_search = false;
});

if (show_search) {
    $("#search-group").hide();
    $("#search-event").show();
} else {
    $("#search-group").show();
    $("#search-event").hide();
}

$("#search-event-btn").click(function()
{
    $("#search-event:hidden").show();
    $("#search-group").hide();
});

$("#search-group-btn").click(function()
{
    $("#search-group").show();
    $("#search-event").hide();
});
