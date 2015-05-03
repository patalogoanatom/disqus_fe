(function() {
  'use strict';
  chrome.runtime.onInstalled.addListener(function(details) {
    return console.log('previousVersion', details.previousVersion);
  });

  chrome.tabs.onActivated.addListener(function(activeInfo) {
    return chrome.tabs.get(activeInfo.tabId, function(tab) {
      var result, url;
      if (tab.url) {
        url = new URL(tab.url);
        result = Backend.getCount(url.host);
        if (url.protocol === 'https:' || url.protocol === 'http:') {
          console.log('Gained ' + result);
          return chrome.browserAction.setBadgeText({
            text: '' + result
          });
        } else {
          return chrome.browserAction.setBadgeText({
            text: ""
          });
        }
      }
    });
  });

}).call(this);
