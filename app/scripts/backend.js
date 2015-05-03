(function() {
  'use strict';
  var $this, module, urlBackend;

  module = typeof exports !== "undefined" && exports !== null ? exports : this;

  urlBackend = 'http://localhost:8000/api/v1/comment/';

  $this = {
    getComments: function(url, callback, errback) {
      var hr;
      hr = new XMLHttpRequest;
      hr.open('GET', urlBackend, true);
      hr.setRequestHeader('Content-type', 'application/json', true);
      hr.onreadystatechange = function() {
        var comment, data, gravatar, i, _i, _len, _ref;
        if (hr.readyState === 4 && hr.status === 200) {
          data = JSON.parse(hr.responseText);
          _ref = data.objects;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            i = _ref[_i];
            gravatar = '<img style="border: solid white 1px;border-radius: 50%;width:30px;height:30px; margin:0 8px 7px 0" src="https://s.gravatar.com/avatar/' + hex_md5(i.email) + '?s=80">';
            comment = '<p>' + gravatar;
            comment += '<span style="font-style: bold; font-size: 20px;">' + i.author + '</span>';
            comment += '<span style="text-align:right; float: right;">' + i.pub_date.substring(0, 10) + '</span></p><div style = "clear:both;"></div>';
            comment += '<p style="font-style: italic;">' + i.text + '</p>';
            $('#comments').append(comment);
          }
        }
      };
      return hr.send(null);
    },
    getCount: function(url, callback, errback) {
      var count, hr;
      hr = new XMLHttpRequest;
      hr.open('GET', urlBackend, true);
      hr.setRequestHeader('Content-type', 'application/json', true);
      count = 0;
      hr.onreadystatechange = function() {
        var data, i, _i, _len, _ref;
        if (hr.readyState === 4 && hr.status === 200) {
          data = JSON.parse(hr.responseText);
          _ref = data.objects;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            i = _ref[_i];
            if (url === i.url) {
              count++;
              console.log(count);
            } else {
              count = 0;
            }
          }
        }
      };
      hr.send(null);
      return "asdsadasad";
    },
    newComment: function(url, name, email, comment, callback, errback) {}
  };

  module.Backend = $this;

}).call(this);
