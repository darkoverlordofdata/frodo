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


  start = new Date().getTime()
  nfcall exec, 'coffee -o tmp -c -b src'

  .then ->
      nfcall exec, 'browserify --debug tmp/sociogram/main.js > www/sociogram/js/app.js'

  .then ->
      nfcall exec, 'browserify --debug tmp/sociogram/main.js | uglifyjs > www/sociogram/js/app.min.js'

  .then ->
      nfcall exec, 'browserify --debug tmp/scrumptious/main.js > www/scrumptious/js/app.js'

  .then ->
      nfcall exec, 'browserify --debug tmp/scrumptious/main.js | uglifyjs > www/scrumptious/js/app.min.js'

  .fail ($err) ->
    util.error $err

  .done ($args) ->
    util.log $text for $text in $args when not /\s*/.test $text
    util.log "Compiled in #{new Date().getTime() - start} ms"
