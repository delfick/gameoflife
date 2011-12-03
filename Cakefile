{spawn} = require 'child_process'
watch = require 'watch'

runJade = -> spawn './bin/jade.sh', [], customFds:[0..2]
runStylus = -> spawn './bin/stylus.sh', [], customFds:[0..2]
runCoffee = -> spawn './bin/coffee.sh', [], customFds:[0..2]
runTests = ->
    console.log '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    spawn './tests.coffee', [], customFds:[0..2]

startWatching = ->
    runJade()
    runCoffee()
    runStylus()
    runTests()
    
    watch.createMonitor 'templates', (monitor) ->
        monitor.on "changed", ->
            runJade()
    
    watch.createMonitor 'src', (monitor) ->
        monitor.on "changed", (f) ->
            if f[-5..] == '.styl'
                runStylus()
            runTests()
    
    watch.createMonitor 'specs', (monitor) ->
        monitor.on "changed", (f) ->
            runTests()

task 'watch', startWatching
task 'server', ->
    spawn './bin/run.sh', [], customFds:[0..2]
    startWatching()
