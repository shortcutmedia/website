(function(window) {

  // from http://www.w3schools.com/js/js_cookies.asp
  function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;

    return cvalue;
  }

  // from http://www.w3schools.com/js/js_cookies.asp
  function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1);
      if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
  }

  function generateRandomUUID() {
    function s4() { return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1) }
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4()
  }

  var iframeCid = getCookie('iframeCid') || setCookie('iframeCid', generateRandomUUID());

  window.insertCreateShortcutFrame = function() {
    document.write('<iframe src="http://manager.shortcutmedia.com/shortcut_generator/uri/new?embedded=1#ga_cid='+iframeCid+'" class="one_field_input" width="650" height="90" align="left" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>')
  }

})(window);
