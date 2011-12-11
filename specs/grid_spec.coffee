{Grid} = require '../src/grid'
        
describe "Grid", ->
    beforeEach ->
        @g = new Grid()
    
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
        @g = new Grid()
        for cells, col in grid
            for cell, row in cells
                if cell is 2 or cell is null then subject = [row, col]
                if cell then @g.setLiveCell [row, col]
        
        [subject, @g]
    
    describe "Determining changes", ->
        it "changes any live cell with 0 live neighbours", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 0, 0]
                [0, 2, 0, 0]
                [0, 0, 0, 0]
            ]
            
            expect(grid.needChange subject).toBe true
        
        it "changes any live cell with only 1 live neighbour", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 0, 0]
                [1, 2, 0, 0]
                [0, 0, 0, 0]
            ]
            
            expect(grid.needChange subject).toBe true
        
        it "doesn't change any live cell with two live neighbours", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 0, 0]
                [1, 2, 0, 0]
                [0, 1, 0, 0]
            ]
            
            expect(grid.needChange subject).toBe false
        
        it "doesn't change any live cell with three live neighbours", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 0, 1, 0]
                [1, 2, 0, 0]
                [0, 1, 0, 0]
            ]
            
            expect(grid.needChange subject).toBe false
        
        it "changes any live cell with more than three live neighbours", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0]
                [0, 1, 1, 0]
                [1, 2, 0, 0]
                [0, 1, 0, 0]
            ]
            
            expect(grid.needChange subject).toBe true
        
        it "changes any dead cell with exactly three live neighbours", ->
            [subject, grid] = makeWorld [
                [0, 0,    0, 0]
                [0, 0,    1, 0]
                [1, null, 0, 0]
                [0, 1,    0, 0]
            ]
            
            expect(grid.needChange subject).toBe true
        
    describe "Update", ->
        it "updates correctly", ->
            [subject, grid] = makeWorld [
                [0, 0, 0, 0, 0, 0]
                [0, 0, 1, 0, 0, 0]
                [0, 1, 0, 1, 0, 0]
                [0, 1, 0, 1, 0, 0]
                [0, 0, 1, 0, 1, 0]
                [0, 0, 0, 0, 0, 0]
            ]
            
            [subject, lookat] = makeWorld [
                [0, 1, 1, 1, 0, 0]
                [1, 1, 1, 1, 1, 0]
                [1, 1, 1, 1, 1, 0]
                [1, 1, 1, 1, 1, 1]
                [1, 1, 1, 1, 1, 1]
                [0, 1, 1, 1, 1, 1]
            ]
            
            changeable = grid.changeable()
            changeableAsDict = {}
            for coord in changeable
                changeableAsDict[coord] = true
            
            expect(changeableAsDict).toEqual lookat.liveCells
            
            [subject, grid2] = makeWorld [
                [0, 0, 0, 0, 0, 0]
                [0, 0, 1, 0, 0, 0]
                [0, 1, 0, 1, 0, 0]
                [0, 1, 0, 1, 1, 0]
                [0, 0, 1, 1, 0, 0]
                [0, 0, 0, 0, 0, 0]
            ]
            
            grid.update()
            expect(grid.liveCells).toEqual grid2.liveCells
            
