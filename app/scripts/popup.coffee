'use strict';

# this script is used in popup.html

Stat =
  data: {}
  cur: null

chrome.storage.sync.get 'disqus.data', (item) ->
  if item['disqus.data']
    console.log "STORAGE"
    console.log JSON.parse(item['disqus.data'])
    Stat.data = JSON.parse(item['disqus.data'])

saveInfo = (url) ->
  if Stat.cur
  	lst = Stat.data[Stat.cur]
  Stat.cur = url
  lst = Stat.data[url] or []
  lst.push($('#inputName').val())
  lst.push($('#inputEmail').val())
  Stat.data[url] = lst
  chrome.storage.sync.set {'disqus.data': JSON.stringify(Stat.data)}

validateEmail = (email) ->
  re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
  re.test email

getHostName = (href) ->
	l = document.createElement('a')
	l.href = href
	l

if $('#inputEmail').val() == '' || $('#inputEmail').val() == null && $('#inputName').val() == '' || $('#inputName').val() == null
	$( "#inputComment" ).attr( "disabled", "" );

$('#inputEmail').on 'focusout', (e) ->
	if $('#inputEmail').val() != '' && $('#inputName').val() != '' && validateEmail $('#inputEmail').val()
		$( "#inputComment" ).removeAttr("disabled")
	else
		$( "#inputComment" ).attr( "disabled", "" )

$('#inputName').on 'focusout', (e) ->
	if $('#inputEmail').val() != '' && $('#inputName').val() != '' && validateEmail $('#inputEmail').val()
		$( "#inputComment" ).removeAttr("disabled")
	else
		$( "#inputComment" ).attr( "disabled", "" )

$('#inputComment').on 'keyup', (e) ->
	if e.keyCode == 13
		chrome.tabs.query {
			active: true
			currentWindow: true
			}, (tab) ->
				saveInfo getHostName(tab[0].url).host
				Backend.newComment(getHostName(tab[0].url).host, $('#inputName').val(), $('#inputEmail').val(), $('#inputComment').val())
				return    
  	return

chrome.tabs.query {
  active: true
  currentWindow: true
}, (tab) ->
	console.log getHostName(tab[0].url).host
	Backend.getComments(getHostName(tab[0].url).host)
	lst = Stat.data[getHostName(tab[0].url).host]
	if(lst)
		$('#inputEmail').val(lst[lst.length-1])
		$('#inputName').val(lst[lst.length-2])
	return
