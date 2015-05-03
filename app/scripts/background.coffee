'use strict';

# this script is used in background.html

chrome.runtime.onInstalled.addListener (details) ->
  console.log('previousVersion', details.previousVersion)

# Stat =
#   data: {}
#   cur: null

# chrome.storage.sync.get 'disqus.data', (item) ->
#   if item['disqus.data']
#     console.log "STORAGE"
#     console.log JSON.parse(item['disqus.data'])
#     Stat.data = JSON.parse(item['disqus.data'])

# tabChanged = (url) ->
#   if Stat.cur
#     lst = Stat.data[Stat.cur]
#   Stat.cur = url
#   lst = Stat.data[url] or []
#   Stat.data[url] = lst

# chrome.storage.sync.set {'disqus.data': JSON.stringify(Stat.data)}

chrome.tabs.onActivated.addListener (activeInfo)->
  chrome.tabs.get activeInfo.tabId, (tab) ->
    
    if tab.url
    
      url = new URL(tab.url)
    
      if url.protocol == 'https:' || url.protocol == 'http:'
      	console.log url.host
      	console.log 'Count: ' + Backend.getCount(url.host)
      	chrome.browserAction.setBadgeText({text: '' + Backend.getCount(url.host)})
    	
      else
        chrome.browserAction.setBadgeText({text: ""})