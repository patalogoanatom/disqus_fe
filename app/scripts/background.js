(function() {
  'use strict';
  chrome.runtime.onInstalled.addListener(function(details) {
    return console.log('previousVersion', details.previousVersion);
  });

  chrome.tabs.onActivated.addListener(function(activeInfo) {
    console.log("Select " + activeInfo.tabId + " ");
    return chrome.tabs.get(activeInfo.tabId, function(tab) {
      var url;
      if (tab.url) {
        url = new URL(tab.url);
        if (url.protocol === 'https:' || url.protocol === 'http:') {
          return console.log(url.hostname);
        } else {
          return chrome.browserAction.setBadgeText({
            text: ""
          });
        }
      }
    });
  });

}).call(this);
