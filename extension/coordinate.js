(function() {
  var Coordinate;
  Coordinate = (function() {
    function Coordinate(x, y) {
      this.x = x;
      this.y = y;
    }
    Coordinate.prototype.getPosition = function() {
      return [this.x, this.y];
    };
    return Coordinate;
  })();
  if (typeof exports === "undefined" || exports === null) {
    exports = window;
  }
  exports.Coordinate = Coordinate;
}).call(this);
