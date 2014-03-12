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
    nfcall exec, 'browserify --debug tmp/nc/main.js  > www/nc/js/app.js'

  .then ->
    nfcall exec, 'browserify --debug tmp/ld/main.js > www/ld/js/app.dbg.js'

  .then ->
    nfcall exec, 'browserify tmp/ld/main.js | uglifyjs > www/ld/js/app.min.js'

  .fail ($err) ->
    util.error $err

  .done ($args) ->
    util.log $text for $text in $args when not /\s*/.test $text
    util.log "Compiled in #{new Date().getTime() - start} ms"
