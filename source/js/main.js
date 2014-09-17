//= require vendor/jquery-placeholder.js
//


// Avoid `console` errors in browsers that lack a console.
if (!(window.console && console.log)) {
    (function() {
        var noop = function() {};
        var methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'markTimeline', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
        var length = methods.length;
        var console = window.console = {};
        while (length--) {
            console[methods[length]] = noop;
        }
    }());
}

$(function(){
  var ready = function(){
    // apply jquery placeholder which is a polyfill for IE8/9.
    $('input, textarea').placeholder();
  }
  $(document).ready(ready);
  $(document).on('page:load', ready);
  $(document).ajaxComplete(ready);
});
