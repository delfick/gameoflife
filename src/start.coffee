every = (time, action) -> setInterval(action, time)

cells = {}
    
$ ->
    g = new Grid()
    $html = $ "html"
    $grid = $ ".grid"
    
    cellWidth = 10
    cellHeight = 10
    
    toggle = (coord) ->
        [x, y] = coord
        if x > 0 and y > 0
            if not cells[coord]
                $cell = $("<div/>").addClass("cell").css left:x*cellWidth, top:y*cellHeight
                $grid.append $cell
                cells[coord] = $cell
                
            cells[coord].toggleClass("live")
    
    addCell = (coord) ->
        if g.setLiveCell coord then toggle coord
    
    # Setup mouse drag ability
    clicking = false
    $html.mousedown -> clicking = true
    $html.mouseup -> clicking = false
    onMouseMove = _.throttle (e) ->
        return unless clicking
        addCell [
            Math.round(e.pageX/cellWidth)
            Math.round(e.pageY/cellHeight)
        ]
    , 50
    
    $html.mousemove onMouseMove
        
    # Update every 500 milliseconds
    every 500, ->
        g.update
            context:this
            perChange: (coord) ->
                toggle coord
