#+--------------------------------------------------------------------+
#| fbapi.coffee
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
#	FbApi
#

muninn = require('muninn')

class FbApi extends muninn.core.Controller

  fb = require('fb')

  @routes =
    '/search':    'searchAction'
    '/friends':   'friendsAction'
    '/announce':  'announceAction'


  #
  # searchAction
  #
  # @return [None]
  #
  searchAction: ->

    parameters = @req.query
    parameters.access_token = @req.session.access_token
    fb.api '/search', @req.query,  (result) =>

      if not result or result.error
        return @res.send(500, 'error')
      @res.send(result)


  #
  # friendsAction
  #
  # @return [None]
  #
  friendsAction: ->

    fb.api 'me/friends',
      fields:         'name,picture'
      limit:          250
      access_token:   @req.session.access_token
    , (result) =>

      if not result or result.error
        return @res.send(500, 'error')
      @res.send(result)

  #
  # announceAction
  #
  # @return [None]
  #
  announceAction: ->

    parameters = @req.body
    parameters.access_token = @req.session.access_token
    fb.api '/me/' + muninn.config.fb.appNamespace +':eat', 'post', parameters , (result) =>
      if not result
        return @res.send(500, 'error')
      else if result.error
        if result.error.type is 'OAuthException'
          result.redirectUri = fb.getLoginUrl({ scope: 'user_about_me,publish_actions', state: encodeURIComponent(JSON.stringify(parameters)) })
        return @res.send 500, result
      @res.send result


module.exports = FbApi