'use strict';

# this script is supposed to have backend related code

module = exports ? this
result = 0
urlBackend = 'http://localhost:8000/api/v1/comment/'

$this =
  getComments: (url, callback, errback) ->
    hr = new XMLHttpRequest
    hr.open 'GET', urlBackend, true
    hr.setRequestHeader 'Content-type', 'application/json', true
    console.log url

    hr.onreadystatechange = ->
      if hr.readyState == 4 and hr.status == 200
        data = JSON.parse(hr.responseText)
        for i in data.objects
        	if i.url == url
	        	gravatar = '<img style="border: solid white 1px;border-radius: 50%;width:30px;height:30px; margin:0 8px 7px 0" src="https://s.gravatar.com/avatar/' + hex_md5(i.email) + '?s=80">'
	        	comment = '<p>' + gravatar
	        	comment += '<span style="font-style: bold; font-size: 20px;">' + i.author + '</span>'
	        	comment += '<span style="text-align:right; float: right;">' + i.pub_date.substring(0, 10) + '</span></p><div style = "clear:both;"></div>'
	        	comment += '<p style="font-style: italic;">' + i.text + '</p>'
	        	$('#comments').append comment
      return

    hr.send null

  getCount: (url, callback, errback)->
  	count = 0
  	xhr = new XMLHttpRequest
  	xhr.open 'GET', urlBackend, true
  	xhr.setRequestHeader 'Content-type', 'application/json', true
  	xhr.send null

  	xhr.onload = (e) ->
  		if xhr.readyState == 4
  			if xhr.status == 200
  				data = JSON.parse(xhr.responseText)
  				for i in data.objects
  					if url == i.url
  						++count
  				result = count
  				console.log 'Real ' + result
  			else
  				console.error xhr.statusText
  		return

  	return result
    # hr = new XMLHttpRequest
    # hr.open 'GET', urlBackend, true
    # hr.setRequestHeader 'Content-type', 'application/json', true
    # hr.send null
    # count = 0
    # hr.onreadystatechange = ->
    #   if hr.status == 200
    #     data = JSON.parse(hr.responseText)
    #     for i in data.objects
    #     	if url == i.url
    #     		count++
    #     		console.log count
    #     	else
    #     		count = 0
    #   return
    # return count

  newComment: (url, name, email, comment, callback, errback) ->
    # console.log('Popup 3')

module.Backend = $this