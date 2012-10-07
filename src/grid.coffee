class Grid
    constructor: () ->
        @liveCells = {}
    
    setLiveCell: (coord) ->
        [x, y] = coord
        created = false
        if x >= 0 and y >= 0 and not @liveCells[coord]?
            created = true
            @liveCells[coord] = true
        created
    
    getSurrounding: ([x, y]) ->
        [
            [x-1, y-1] # top left
            [x,   y-1] # top
            [x+1, y-1] # top right
            [x+1, y  ] # right
            [x+1, y+1] # bottom right
            [x,   y+1] # bottom
            [x-1, y+1] # bottom left
            [x-1, y  ] # left
        ]
    
    needChange: (coord) ->
        alive = @liveCells[coord]?
        
        # Determine count of alive neighbours        
        func = (total, n) => total + if @liveCells[n] then 1 else 0
        count = _.reduce @getSurrounding(coord), func, 0
        
        # Determine whether we need to change the status of this coordinate
        alive != if not alive and count is 3
                true
            else if count < 2
                false
            else if count > 3
                false
            else
                alive
            
    toggle: (coord) ->
        current = @liveCells[coord]
        if current
            delete @liveCells[coord]
        else
            @liveCells[coord] = true

    changeable: ->
        wanted = for own coord of @liveCells
            # Get two Numbers from the coord
            [x, y] = coord.split(',')
            xy = [x, y] = [Number(x), Number(y)]
            
            # Get the list of both current cell and all surrounding cells
            [xy].concat @getSurrounding xy
        _.flatten wanted, 1
        
    update: ({context, perChange, noChanged}={}) ->
        checked = {}
        changed = for coord in @changeable()
            [x, y] = coord
            if checked[coord]? then continue
            
            change = @needChange coord
            checked[coord] = true
            if not change then continue
            
            coord
        
        if changed.length is 0
            noChanged?.call context
        else
            for coord in changed
                @toggle coord
                perChange?.call context, coord
        
        return

########################
#   EXPORT
########################

if not exports?
  exports = window
exports.Grid = Grid
