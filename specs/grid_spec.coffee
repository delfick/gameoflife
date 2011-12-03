{Grid} = require '../src/grid'
        
describe "Grid", ->
    beforeEach ->
        @g = new Grid()
        
    describe "Setting live cells", ->
        it "can be given a list of coordinates representing live cells", ->
            @g.setLiveCells [5, 6]
            expect(@g.liveCells).toEqual [[5, 6]]
        
        it "changes list of changed cells", ->
            @g.changedCells = [[4, 4]]
            @g.setLiveCells [5, 6], [7, 8]
            expect(@g.liveCells).toEqual [[5, 6], [7, 8]]
            expect(@g.changedCells).toEqual [[4, 4], [5, 6], [7, 8]]
        
        it "sets up hash of all cells", ->
    
    it "has a method to get nine coords from a single coord", ->
        coord = [4, 5]
        surrounding = @g.getSurrounding(coord)
        expect(surrounding).toEqual [
            [3, 4] # top left
            [4, 4] # top
            [5, 4] # top right
            [5, 5] # right
            [5, 6] # bottom right
            [4, 6] # bottom
            [3, 6] # bottom left
            [3, 5] # left
        ]
        
    makeWorld = (grid) ->
        liveCells = []
        for cells, row in grid
            for cell, col in cells
                if cell is 2 or cell is null then subject = [row, col]
                if cell then liveCells.push [row, col]
        
        @g = new Grid row, col
        @g.setLiveCells.apply @g, liveCells
        [subject, @g]
    
    describe "Next state for a cell", ->
        it "any live cell with 0 live neighbours dies", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 0, 0]
                [0, 2, 0, 0]
                [0, 0, 0, 0]
            ]
            
            expect(grid.nextState subject).toBe false
        
        it "any live cell with only 1 live neighbour dies", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 0, 0]
                [1, 2, 0, 0]
                [0, 0, 0, 0]
            ]
            
            expect(grid.nextState subject).toBe false
        
        it "any live cell with two live neighbours lives", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 0, 0]
                [1, 2, 0, 0]
                [0, 1, 0, 0]
            ]
            
            expect(grid.nextState subject).toBe true
        
        it "any live cell with three live neighbours lives", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 1, 0]
                [1, 2, 0, 0]
                [0, 1, 0, 0]
            ]
            
            expect(grid.nextState subject).toBe true
        
        it "any live cell with more than three live neighbours dies", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 1, 1, 0]
                [1, 2, 0, 0]
                [0, 1, 0, 0]
            ]
            
            expect(grid.nextState subject).toBe false
        
        it "any dead cell with exactly three live neighbours becomes alive", ->
            [subject, grid] = makeWorld [
                [0, 0,    0, 0]
                [0, 0,    1, 0]
                [1, null, 0, 0]
                [0, 1,    0, 0]
            ]
            
            expect(grid.nextState subject).toBe true
        
    describe "Update", ->
        it "creates a list of the changed cells", ->
            
        
        it "changes the list of alive cells", ->
