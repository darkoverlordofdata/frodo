#+--------------------------------------------------------------------+
#| Cakefile
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of Frodo
#|
#| Frodo is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# cake utils
#
fs = require 'fs'
util = require 'util'
{exec} = require 'child_process'
{nfcall} = require 'q'


#
# Build Source
#
#
task 'build:src', 'Build the coffee app', ->

  if not fs.existsSync('tmp/') then fs.mkdirSync('tmp')
  if not fs.existsSync('www/') then fs.mkdirSync('www')
  if not fs.existsSync('www/js/') then fs.mkdirSync('www/js')

  start = new Date().getTime()
  nfcall exec, 'coffee -o tmp -c -b src'

  .then ->
    nfcall exec, 'browserify --debug tmp/gridster/app.js > www/gridster/js/app.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/gridster/app.js | uglifyjs > www/gridster/js/app.min.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/sociogram/index.js > www/sociogram/js/app.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/sociogram/index.js | uglifyjs > www/sociogram/js/app.min.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/scrumptious/index.js > www/scrumptious/js/app.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/scrumptious/index.js | uglifyjs > www/scrumptious/js/app.min.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/letsdolunch/index.js > www/letsdolunch/js/app.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/letsdolunch/index.js | uglifyjs > www/letsdolunch/js/app.min.js'

  .fail ($err) ->
    util.error $err

  .done ($args) ->
    util.log $text for $text in $args when not /\s*/.test $text
    util.log "Compiled in #{new Date().getTime() - start} ms"
