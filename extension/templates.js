
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
    __.buf.push('<div');
    __.buf.push(__.attrs({
      'class': 'main'
    }));
    __.buf.push('><p>Hello</p></div>');
    };
    return __.buf.join("");
  });
  return templates;
});

})();
