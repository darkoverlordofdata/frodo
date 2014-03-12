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

  fb = require('fb')
  fb.options
    appId:          muninn.config.fb.appId
    appSecret:      muninn.config.fb.appSecret
    redirectUri:    muninn.config.fb.redirectUri

  @routes =
    '/demo':            'indexAction'
    '/login/callback':  'loginCallback'
    '/logout':          'logoutAction'


  #
  # indexAction
  #
  # @return [None]
  #
  indexAction: ->
    accessToken = @req.session.access_token
    if not accessToken
      console.log @req.session
      @res.render 'demo/index',
        title: 'Express',
        loginUrl: fb.getLoginUrl(scope: 'user_about_me')
    else
      @res.render 'demo/menu'


  #
  # loginCallback
  #
  # @return [None]
  #
  loginCallback: ->
    code = @req.query.code

    if @req.query.error
      return @res.send 'login-error ' + @req.query.error_description
    else if not code
      return @res.redirect '/demo'

    fb.api 'oauth/access_token',
      client_id:      fb.options('appId')
      client_secret:  fb.options('appSecret')
      redirect_uri:   fb.options('redirectUri')
      code:           code
    , (result) =>

      if not result or result.error then throw result.error
      fb.api 'oauth/access_token',
        client_id:          fb.options('appId')
        client_secret:      fb.options('appSecret')
        grant_type:         'fb_exchange_token'
        fb_exchange_token:  result.access_token
      , (result) =>

        if not result or result.error then throw result.error
        @req.session.access_token    = result.access_token
        @req.session.expires         = result.expires or 0

        if @req.query.state
          parameters                = JSON.parse(@req.query.state)
          parameters.access_token   = @req.session.access_token

#          console.log(parameters)

          fb.api '/me/' + config.fb.appNamespace +':eat', 'post', parameters , (result) =>
#            console.log(result)
            if not result || result.error
              return @res.send(500, result or 'error')


          return @res.redirect('/demo')
        else
          return @res.redirect('/demo')



  #
  # logoutAction
  #
  # @return [None]
  #
  logoutAction: ->
    @req.session = null
    @res.redirect '/demo'



module.exports = FbDemo