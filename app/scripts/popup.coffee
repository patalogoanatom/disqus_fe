'use strict';

# this script is used in popup.html

validateEmail = (email) ->
  re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
  re.test email

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
    alert 'some string'
  return

getComments = Backend.getComments('google.com')