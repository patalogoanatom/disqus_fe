'use strict';

# this script is used in background.html

chrome.runtime.onInstalled.addListener (details) ->
  console.log('previousVersion', details.previousVersion)

chrome.tabs.onActivated.addListener (activeInfo)->
  console.log "Select #{activeInfo.tabId} "
  chrome.tabs.get activeInfo.tabId, (tab) ->
    if tab.url
      url = new URL(tab.url)
      if url.protocol == 'https:' || url.protocol == 'http:'
      	console.log url.hostname
      else
        chrome.browserAction.setBadgeText({text: ""})
