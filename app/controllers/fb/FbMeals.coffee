#+--------------------------------------------------------------------+
#| meals.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of Frodo
#|
#| Frodo is free software you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
#	Demo
#

muninn = require('muninn')

class FbMeals extends muninn.core.Controller

  #fb = require('fb')

  @routes =
    '/meals/:id':       'indexAction'

  meals:
    cheeseburger:   "Cheeseburger"
    chinese:        "Chinese"
    french:         "French"
    hotdog:         "Hot Dog"
    indian:         "Indian"
    italian:        "Italian"
    pizza:          "Pizza"
  

  #
  # indexAction
  #
  # @return [None]
  #
  indexAction: (id) ->

    if not @meals[id]
      return @res.send(404)

    @res.render 'meal',
      appId:          muninn,config.facebook.appId,
      appNamespace:   muninn,config.facebook.appNamespace,
      meal:
        id:         id
        title:      @meals[id]
        url:        muninn.config.rootUrl + 'meals/' + id
        imageUrl:   muninn.config.rootUrl + 'images/meals/' + id + '-full.png'





module.exports = FbMeals