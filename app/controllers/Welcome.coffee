#+--------------------------------------------------------------------+
#| welcome.coffee
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
#	welcome
#
muninn = require('muninn')

class Welcome extends muninn.core.Controller

  @routes =
    '/' : 'indexAction'

  indexAction: ->

    @res.render 'page',
      title : 'frodo'
      id : 'main'
      links: [
        { name : 'Facebook Demo using Thuzi/facebook-node-sdk', url : '/demo' }
        { name : 'Sociogram Clone/Demo', url : '/sociogram.html' }
      ]
      upperHelper: (string) ->
        string.toUpperCase()

module.exports = Welcome