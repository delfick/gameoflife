(function() {
  var Grid;
  var __hasProp = Object.prototype.hasOwnProperty;
  Grid = (function() {
    function Grid() {
      this.liveCells = {};
    }
    Grid.prototype.setLiveCell = function(coord) {
      var created, x, y;
      x = coord[0], y = coord[1];
      created = false;
      if (x > 0 && y > 0 && !(this.liveCells[coord] != null)) {
        created = true;
        this.liveCells[coord] = true;
      }
      return created;
    };
    Grid.prototype.getSurrounding = function(_arg) {
      var x, y;
      x = _arg[0], y = _arg[1];
      return [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1], [x + 1, y], [x + 1, y + 1], [x, y + 1], [x - 1, y + 1], [x - 1, y]];
    };
    Grid.prototype.needChange = function(coord, count) {
      var current;
      return true;
      current = this.liveCells[coord];
      return current !== (!current && count === 3 ? true : count < 2 ? false : count > 3 ? false : true);
    };
    Grid.prototype.toggle = function(coord) {
      var current;
      current = this.liveCells[coord];
      if (current) {
        return delete this.liveCells[coord];
      } else {
        return this.liveCells[coord] = true;
      }
    };
    Grid.prototype.findChangesAround = function(coord, checked, changed) {
      var count, scoord, surrounding, _i, _j, _len, _len2;
      if (changed == null) {
        changed = [];
      }
      if (checked[coord] == null) {
        checked[coord] = true;
        count = 0;
        surrounding = this.getSurrounding(coord);
        for (_i = 0, _len = surrounding.length; _i < _len; _i++) {
          scoord = surrounding[_i];
          if (this.liveCells[scoord]) {
            count += 1;
          }
        }
        if (this.needChange(coord, count)) {
          changed.push(coord);
          this.liveCells[coord] = true;
        }
        if (count > 0) {
          for (_j = 0, _len2 = surrounding.length; _j < _len2; _j++) {
            scoord = surrounding[_j];
            this.findChangesAround(scoord, checked, changed);
          }
        }
      }
      return changed;
    };
    Grid.prototype.update = function(_arg) {
      var c, changed, checked, context, coord, noChanged, perChange, _i, _j, _len, _len2, _ref, _ref2, _ref3, _results;
      _ref = _arg != null ? _arg : {}, context = _ref.context, perChange = _ref.perChange, noChanged = _ref.noChanged;
      changed = [];
      checked = {};
      _ref2 = this.liveCells;
      for (coord in _ref2) {
        if (!__hasProp.call(_ref2, coord)) continue;
        _ref3 = this.findChangesAround(coord.split(','), checked);
        for (_i = 0, _len = _ref3.length; _i < _len; _i++) {
          c = _ref3[_i];
          changed.push(c);
        }
      }
      if (changed.length === 0) {
        return noChanged != null ? noChanged.call(context) : void 0;
      } else {
        _results = [];
        for (_j = 0, _len2 = changed.length; _j < _len2; _j++) {
          coord = changed[_j];
          this.toggle(coord);
          _results.push(perChange != null ? perChange.call(context, coord) : void 0);
        }
        return _results;
      }
    };
    return Grid;
  })();
  if (typeof exports === "undefined" || exports === null) {
    exports = window;
  }
  exports.Grid = Grid;
}).call(this);
