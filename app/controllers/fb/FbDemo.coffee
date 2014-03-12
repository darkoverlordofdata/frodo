#+--------------------------------------------------------------------+
#| demo.coffee
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


class FbDemo extends muninn.core.Controller

  graph = require('fbgraph')

  @routes =
    '/demo':            'indexAction'
    '/login/callback':  'authAction'
    '/logout':          'logoutAction'
    '/loggedin':        'loginAction'


  #
  # indexAction
  #
  # @return [None]
  #
  indexAction: ->
    @res.render 'demo/index',
      title: 'Express',
      loginUrl: "/login/callback"


  #
  # authAction
  #
  # @return [None]
  #
  authAction: ->

    console.log 'AT authAction'
    if not @req.query.code

      authUrl = graph.getOauthUrl
        client_id:     muninn.config.fb.appId
        redirect_uri:  muninn.config.fb.redirectUri
        scope:         'user_about_me'
      console.log 'authUrl = '+authUrl

      if not @req.query.error # checks whether a user denied the app facebook login/permissions
        @res.redirect authUrl
      else # req.query.error == 'access_denied'
        @res.send 'access denied'
      return

    graph.authorize
      client_id:      muninn.config.fb.appId
      redirect_uri:   muninn.config.fb.redirectUri
      client_secret:  muninn.config.fb.appSecret
      code:           @req.query.code
    , (err, f) =>
        @res.redirect '/loggedin'


  loginAction: ->
    @res.render 'demo/menu'

  #
  # logoutAction
  #
  # @return [None]
  #
  logoutAction: ->
    @req.session = null
    @res.redirect '/demo'



module.exports = FbDemo