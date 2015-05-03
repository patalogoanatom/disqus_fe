(function() {
  'use strict';
  var $this, module, urlBackend;

  module = typeof exports !== "undefined" && exports !== null ? exports : this;

  urlBackend = 'http://localhost:8000/api/v1/comment/';

  $this = {
    getComments: function(url, callback, errback) {
      var count, hr;
      hr = new XMLHttpRequest;
      hr.open('GET', urlBackend, true);
      hr.setRequestHeader('Content-type', 'application/json', true);
      count = 0;
      hr.onreadystatechange = function() {
        var comment, data, gravatar, i, _i, _len, _ref;
        if (hr.readyState === 4 && hr.status === 200) {
          data = JSON.parse(hr.responseText);
          _ref = data.objects;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            i = _ref[_i];
            if (i.url === url) {
              count++;
              gravatar = '<img style="border: solid white 1px;border-radius: 50%;width:30px;height:30px; margin:0 8px 7px 0" src="https://s.gravatar.com/avatar/' + hex_md5(i.email) + '?s=80">';
              comment = '<p>' + gravatar;
              comment += '<span style="font-style: bold; font-size: 20px;">' + i.author + '</span>';
              comment += '<span style="text-align:right; float: right;">' + i.pub_date.substring(0, 10) + '</span></p><div style = "clear:both;"></div>';
              comment += '<p style="font-style: italic;">' + i.text + '</p>';
              $('#comments').append(comment);
            }
          }
          $('#amount_comments').append(count + ' comments');
        }
      };
      return hr.send(null);
    },
    getCount: function(url, callback, errback) {
      var count, xhr;
      count = 0;
      xhr = new XMLHttpRequest;
      xhr.open('GET', urlBackend, true);
      xhr.setRequestHeader('Content-type', 'application/json', true);
      xhr.send(null);
      return xhr.onload = function(e) {
        var data, i, _i, _len, _ref;
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            data = JSON.parse(xhr.responseText);
            _ref = data.objects;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              i = _ref[_i];
              if (url === i.url) {
                count++;
              }
            }
            chrome.browserAction.setBadgeText({
              text: '' + count
            });
            console.log('Real ' + result);
          } else {
            console.error(xhr.statusText);
          }
        }
      };
    },
    newComment: function(url, name, email, comment, callback, errback) {
      var json, xhr;
      xhr = new XMLHttpRequest;
      json = JSON.stringify;
      ({
        url: url,
        name: name,
        email: email,
        comment: comment
      });
      xhr.open('POST', urlBackend, true);
      xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
      xhr.onreadystatechange = function() {
        if (this.readyState !== 4) {
          return;
        }
        alert(this.responseText);
      };
      console.log(json);
      return xhr.send(json);
    }
  };

  module.Backend = $this;

}).call(this);
