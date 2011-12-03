
(function() {
var exports;
var define = function(f) {
    if (typeof exports !== "undefined" && exports !== null) {
        exports;
    } else {
        exports = window;
    };
    var templates = exports.templates = f();
    exports.partial = templates.partial = function(str, locals) { return templates['templates/' + str + '.jade'](locals);}
};


define(function() {
  var templates;
  templates = {};
  templates['templates/layout.jade'] = (function(locals) {
    var __;
    __ = jade.init();
    with (locals || {}) {;
    __.buf.push('<!DOCTYPE html><html');
    __.buf.push(__.attrs({
      terse: true,
      'lang': 'en'
    }));
    __.buf.push('><head><title>Game of Life</title><link');
    __.buf.push(__.attrs({
      terse: true,
      'rel': 'stylesheet',
      'type': 'text/css',
      'href': '/theme.css'
    }));
    __.buf.push('><script');
    __.buf.push(__.attrs({
      terse: true,
      'type': 'text/javascript',
      'src': '/libraries/underscore.js'
    }));
    __.buf.push('></script><script');
    __.buf.push(__.attrs({
      terse: true,
      'type': 'text/javascript',
      'src': '/libraries/jquery.js'
    }));
    __.buf.push('></script><script');
    __.buf.push(__.attrs({
      terse: true,
      'type': 'text/javascript',
      'src': '/libraries/jade.js'
    }));
    __.buf.push('></script><script');
    __.buf.push(__.attrs({
      terse: true,
      'type': 'text/javascript',
      'src': '/templates.js'
    }));
    __.buf.push('></script><script');
    __.buf.push(__.attrs({
      terse: true,
      'type': 'text/javascript',
      'src': '/grid.js'
    }));
    __.buf.push('></script><script');
    __.buf.push(__.attrs({
      terse: true,
      'type': 'text/javascript',
      'src': '/start.js'
    }));
    __.buf.push('></script></head><body><div');
    __.buf.push(__.attrs({
      terse: true,
      'class': 'grid'
    }));
    __.buf.push('></div></body></html>');
    };
    return __.buf.join("");
  });
  return templates;
});

})();
