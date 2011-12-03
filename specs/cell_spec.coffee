
        
describe "Cell", ->
    it "has an initial state", ->
        c = new Cell()
        expect(c.state.isDead()).toBe true
