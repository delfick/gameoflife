class Grid
    constructor: () ->
        @liveCells = {}
    
    setLiveCell: (coord) ->
        [x, y] = coord
        created = false
        if x > 0 and y > 0 and not @liveCells[coord]?
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
    
    needChange: (coord, count) ->
        return true
        current = @liveCells[coord]
        current != if not current and count is 3
                true
            else if count < 2
                false
            else if count > 3
                false
            else
                true
            
    toggle: (coord) ->
        current = @liveCells[coord]
        if current
            delete @liveCells[coord]
        else
            @liveCells[coord] = true
    
    findChangesAround: (coord, checked, changed=[]) ->
        # This function needs to be made not recursive
        # Currently it just dies
        unless checked[coord]?
            checked[coord] = true
            
            count = 0
            surrounding = @getSurrounding coord
            for scoord in surrounding
                if @liveCells[scoord] then count += 1
           
            if @needChange coord, count
                changed.push coord
                @liveCells[coord] = true
            
            if count > 0
                for scoord in surrounding
                    @findChangesAround scoord, checked, changed
        changed
    
    update: ({context, perChange, noChanged}={}) ->
        changed = []
        checked = {}
        
        for own coord of @liveCells
            for c in @findChangesAround coord.split(','), checked
                changed.push c
            
        if changed.length is 0
            noChanged?.call context
        else
            for coord in changed
                @toggle coord
                perChange?.call context, coord

########################
#   EXPORT
########################

exports ?= window
exports.Grid = Grid
