#!/usr/bin/env coffee
jasmine = require 'jasmine-node'
fs = require 'fs'
    
# Set Underscore as a global
global._ = require("underscore")._

# Options for tests
done = ->
folder = "#{__dirname}/specs"
matcher = /._spec\.(coffee|js)$/i
teamcity = false
isVerbose = false
showColors = true
junitreport = report:false
useRequireJs = false

# Run the tests
jasmine.executeSpecsInFolder folder, done, isVerbose, showColors, teamcity, useRequireJs, matcher, junitreport
