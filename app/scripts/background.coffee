'use strict';

# this script is used in background.html

chrome.runtime.onInstalled.addListener (details) ->
  console.log('previousVersion', details.previousVersion)

chrome.tabs.onActivated.addListener (activeInfo)->
  chrome.tabs.get activeInfo.tabId, (tab) ->
    if tab.url
      url = new URL(tab.url)
      if url.protocol == 'https:' || url.protocol == 'http:'
      	Backend.getCount(url.host)
      else
        chrome.browserAction.setBadgeText({text: ""})

	