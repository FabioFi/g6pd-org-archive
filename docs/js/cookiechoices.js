var _____WB$wombat$assign$function_____=function(name){return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name))||self[name];};if(!self.__WB_pmw){self.__WB_pmw=function(obj){this.__WB_source=obj;return this;}}{
let window = _____WB$wombat$assign$function_____("window");
let self = _____WB$wombat$assign$function_____("self");
let document = _____WB$wombat$assign$function_____("document");
let location = _____WB$wombat$assign$function_____("location");
let top = _____WB$wombat$assign$function_____("top");
let parent = _____WB$wombat$assign$function_____("parent");
let frames = _____WB$wombat$assign$function_____("frames");
let opens = _____WB$wombat$assign$function_____("opens");
/*
 Copyright 2014 Google Inc. All rights reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Customized by Chanan Zass 2015
 */
//<![CDATA[
(function(window) {

  if (!!window.cookieChoices) {
    return window.cookieChoices;
  }

  var document = window.document;
  // IE8 does not support textContent, so we should fallback to innerText.
  var supportsTextContent = 'textContent' in document.body;
  
  var cookieChoices = (function() {

    var cookieName = 'displayCookieConsent';
    var cookieConsentId = 'cookieChoiceInfo';
    var dismissLinkId = 'cookieChoiceDismiss';

    function _createHeaderElement(cookieText, dismissText, linkText, linkHref) {
        var butterBarStyles = 'position:fixed;width:100%;background-color:#eee;' +
          'margin: 0; top:0;padding:4px;z-index:1000;text-align:center; font-size: 14pt;';

      var cookieConsentElement = document.createElement('div');
      cookieConsentElement.id = cookieConsentId;
      cookieConsentElement.style.cssText = butterBarStyles;
      // cookieConsentElement.style.opacity = 0.9;
      cookieConsentElement.appendChild(_createConsentText(cookieText));

        // move page wrapping div down  // height: 64px;
        // document.getElementById('sfdemo_wrp').style.marginTop = '70px';
      
      
        if (!!linkText && !!linkHref) {
        cookieConsentElement.appendChild(_createInformationLink(linkText, linkHref));
      }
        cookieConsentElement.appendChild(_createDismissLink(dismissText));
      return cookieConsentElement;
    }

    function _createDialogElement(cookieText, dismissText, linkText, linkHref) {
      var glassStyle = 'position:fixed;width:100%;height:100%;z-index:999;' +
          'top:0;left:0;opacity:0.5;filter:alpha(opacity=50);' +
          'background-color:#ccc;';
      var dialogStyle = 'z-index:1000;position:fixed;left:50%;top:50%;';
      var contentStyle = 'position:relative;left:-50%;margin-top:-25%;' +
          'background-color:#fff;padding:20px;box-shadow:4px 4px 25px #888;';

      var cookieConsentElement = document.createElement('div');
      cookieConsentElement.id = cookieConsentId;

      var glassPanel = document.createElement('div');
      glassPanel.style.cssText = glassStyle;

      var content = document.createElement('div');
      content.style.cssText = contentStyle;
      
      var dialog = document.createElement('div');
      dialog.style.cssText = dialogStyle;

      var dismissLink = _createDismissLink(dismissText);
      dismissLink.style.display = 'block';
      dismissLink.style.textAlign = 'right';
      dismissLink.style.marginTop = '8px';
      dismissLink.style.fontSize = '14pt';
      dismissLink.style.color = 'white';

      content.appendChild(_createConsentText(cookieText));
      if (!!linkText && !!linkHref) {
        content.appendChild(_createInformationLink(linkText, linkHref));
      }
      content.appendChild(dismissLink);
      dialog.appendChild(content);
      cookieConsentElement.appendChild(glassPanel);
      cookieConsentElement.appendChild(dialog);
      return cookieConsentElement;
    }

    function _setElementText(element, text) {
      if (supportsTextContent) {
        element.textContent = text;
      } else {
        element.innerText = text;
      }
    }

    function _createConsentText(cookieText) {
      var consentText = document.createElement('span');
      _setElementText(consentText, cookieText);
      return consentText;
    }

    function _createDismissLink(dismissText) {
      var dismissLink = document.createElement('a');
      _setElementText(dismissLink, dismissText);
      dismissLink.id = dismissLinkId;
      dismissLink.href = '#';
      dismissLink.style.marginLeft = '24px';
      dismissLink.className = 'button medium blue';
      dismissLink.style.fontSize = '12pt';
      dismissLink.style.color = 'white';
      return dismissLink;
    }

    function _createInformationLink(linkText, linkHref) {
      var infoLink = document.createElement('a');
      _setElementText(infoLink, linkText);
      infoLink.href = linkHref;
      infoLink.target = '_blank';
      infoLink.style.marginLeft = '8px';
      // infoLink.className = 'button medium blue';
      infoLink.style.fontSize = '14pt';
      return infoLink;
    }

    function _dismissLinkClick() {
      _saveUserPreference();
      _removeCookieConsent();
        // move up wrapping div
      document.getElementById('wrapper').style.marginTop = '0px';
      return false;
    }

    function _showCookieConsent(cookieText, dismissText, linkText, linkHref, isDialog) {
        if (_shouldDisplayConsent()) {
            _removeCookieConsent();
            var consentElement = (isDialog) ?
                _createDialogElement(cookieText, dismissText, linkText, linkHref) :
                _createHeaderElement(cookieText, dismissText, linkText, linkHref);
            var fragment = document.createDocumentFragment();
            fragment.appendChild(consentElement);
            document.body.appendChild(fragment.cloneNode(true));
            document.getElementById(dismissLinkId).onclick = _dismissLinkClick;

            document.getElementById('wrapper').style.marginTop = document.getElementById('cookieChoiceInfo').clientHeight + 1 + 'px';
        } else {
            
        }
    }

    function showCookieConsentBar(cookieText, dismissText, linkText, linkHref) {
      _showCookieConsent(cookieText, dismissText, linkText, linkHref, false);
    }

    function showCookieConsentDialog(cookieText, dismissText, linkText, linkHref) {
      _showCookieConsent(cookieText, dismissText, linkText, linkHref, true);
    }

    function _removeCookieConsent() {
      var cookieChoiceElement = document.getElementById(cookieConsentId);
      if (cookieChoiceElement != null) {
        cookieChoiceElement.parentNode.removeChild(cookieChoiceElement);
      }
    }

    function _saveUserPreference() {
      // Set the cookie expiry to one year after today.
      var expiryDate = new Date();
      expiryDate.setFullYear(expiryDate.getFullYear() + 1);
      document.cookie = cookieName + '=y; expires=' + expiryDate.toGMTString();
    }

    function _shouldDisplayConsent() {
      // Display the header only if the cookie has not been set.
      return !document.cookie.match(new RegExp(cookieName + '=([^;]+)'));
    }

    var exports = {};
    exports.showCookieConsentBar = showCookieConsentBar;
    exports.showCookieConsentDialog = showCookieConsentDialog;
    return exports;
  })();

  window.cookieChoices = cookieChoices;
  return cookieChoices;
})(this);

//]]>

}

/*
     FILE ARCHIVED ON 23:05:48 May 20, 2020 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 07:54:55 Mar 09, 2026.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  capture_cache.get: 28.134
  load_resource: 96.156 (2)
  PetaboxLoader3.datanode: 82.604 (5)
  captures_list: 0.695
  exclusion.robots: 0.022
  exclusion.robots.policy: 0.009
  esindex: 0.012
  cdx.remote: 7.756
  LoadShardBlock: 56.98 (3)
  PetaboxLoader3.resolve: 63.362
*/