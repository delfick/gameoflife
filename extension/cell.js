(function() {
  var Cell;
  Cell = (function() {
    function Cell() {
      this.state = false;
    }
    Cell.prototype.isDead = function() {
      return !this.state;
    };
    Cell.prototype.isAlive = function() {
      return this.state;
    };
    Cell.prototype.kill = function() {
      return this.state = false;
    };
    Cell.prototype.revive = function() {
      return this.state = true;
    };
    return Cell;
  })();
  if (typeof exports === "undefined" || exports === null) {
    exports = window;
  }
  exports.Cell = Cell;
}).call(this);
