#!/bin/sh
coffeejade --amdout compiled/templates.js.1 templates
echo "
(function() {
var exports;
var define = function(f) {
    if (typeof exports !== \"undefined\" && exports !== null) {
        exports;
    } else {
        exports = window;
    };
    var templates = exports.templates = f();
    exports.partial = templates.partial = function(str, locals) { return templates['templates/' + str + '.jade'](locals);}
};
" > compiled/templates.js
cat compiled/templates.js.1 >> compiled/templates.js
echo "
})();" >> compiled/templates.js
rm compiled/templates.js.1

