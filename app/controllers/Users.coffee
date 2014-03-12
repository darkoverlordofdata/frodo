#+--------------------------------------------------------------------+
#| users.coffee
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
#	users
#
muninn = require('muninn')
class Users extends muninn.core.Controller

  @routes =
    '/users' : 'indexAction'

  indexAction: ->
    @res.send "respond with a resource"

module.exports = Users
