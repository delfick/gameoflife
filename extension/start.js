(function() {
  var cells, every;
  every = function(time, action) {
    return setInterval(action, time);
  };
  cells = {};
  $(function() {
    var $grid, $html, addCell, cellHeight, cellWidth, clicking, g, onMouseMove, toggle;
    g = new Grid();
    $html = $("html");
    $grid = $(".grid");
    cellWidth = 10;
    cellHeight = 10;
    toggle = function(coord) {
      var $cell, x, y;
      x = coord[0], y = coord[1];
      if (x > 0 && y > 0) {
        if (!cells[coord]) {
          $cell = $("<div/>").addClass("cell").css({
            left: x * cellWidth,
            top: y * cellHeight
          });
          $grid.append($cell);
          cells[coord] = $cell;
        }
        return cells[coord].toggleClass("live");
      }
    };
    addCell = function(coord) {
      if (g.setLiveCell(coord)) {
        return toggle(coord);
      }
    };
    clicking = false;
    $html.mousedown(function() {
      return clicking = true;
    });
    $html.mouseup(function() {
      return clicking = false;
    });
    onMouseMove = _.throttle(function(e) {
      if (!clicking) {
        return;
      }
      return addCell([Math.round(e.pageX / cellWidth), Math.round(e.pageY / cellHeight)]);
    }, 50);
    $html.mousemove(onMouseMove);
    return every(500, function() {
      return g.update({
        context: this,
        perChange: function(coord) {
          return toggle(coord);
        }
      });
    });
  });
}).call(this);
