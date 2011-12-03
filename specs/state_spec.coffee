

describe "State", ->
    testState = (s, alive) ->
        expect(s.isDead()).toBe not alive
        expect(s.isAlive()).toBe alive
        
    it "defaults to been dead", ->
        s = new State()
        testState(s, false)
    
    it "can change from dead to alive", ->
        s = new State()
        testState(s, false)
        
        s.revive()
        testState(s, true)
    
    it "can change from alive to deads", ->
        s = new State()
        s.revive()
        testState(s, true)
        
        s.kill()
        testState(s, false)
