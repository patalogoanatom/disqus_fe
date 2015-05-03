(function() {
  'use strict';
  var getComments, validateEmail;

  validateEmail = function(email) {
    var re;
    re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return re.test(email);
  };

  if ($('#inputEmail').val() === '' || $('#inputEmail').val() === null && $('#inputName').val() === '' || $('#inputName').val() === null) {
    $("#inputComment").attr("disabled", "");
  }

  $('#inputEmail').on('focusout', function(e) {
    if ($('#inputEmail').val() !== '' && $('#inputName').val() !== '' && validateEmail($('#inputEmail').val())) {
      return $("#inputComment").removeAttr("disabled");
    } else {
      return $("#inputComment").attr("disabled", "");
    }
  });

  $('#inputName').on('focusout', function(e) {
    if ($('#inputEmail').val() !== '' && $('#inputName').val() !== '' && validateEmail($('#inputEmail').val())) {
      return $("#inputComment").removeAttr("disabled");
    } else {
      return $("#inputComment").attr("disabled", "");
    }
  });

  $('#inputComment').on('keyup', function(e) {
    if (e.keyCode === 13) {
      alert('some string');
    }
  });

  getComments = Backend.getComments('google.com');

}).call(this);
