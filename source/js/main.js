//= require vendor/jquery-1.8.0.min
//= require vendor/jquery-placeholder.js
//= require vendor/modal
//= require signup

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

var youtubePlayers = {};
function onYouTubeIframeAPIReady() {
  $('.yt-api').each( function() {
    youtubePlayers[this.id] = new YT.Player(this.id);
  });
}

$(function(){
  var modalShow = function(e) {
    var el = $(e.originalEvent.detail.modal);
    player = youtubePlayers[ el.find('iframe').attr('id') ];
    if (player) {
      player.playVideo();
    }
  }
  var modalHide = function(e) {
    el = $(e.originalEvent.detail.modal);
    player = youtubePlayers[ el.find('iframe').attr('id') ];
    if (player) {
      player.stopVideo();
    }
  }

  var ready = function(){
    // apply jquery placeholder which is a polyfill for IE8/9.
    $('input, textarea').placeholder();
  }

  $(document).ready(ready);
  $(document).on('page:load', ready);
  $(document).ajaxComplete(ready);

  $(document).on('cssmodal:show', modalShow);
  $(document).on('cssmodal:hide', modalHide);
});
