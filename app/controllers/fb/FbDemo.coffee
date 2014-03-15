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

    if @req.query.error
      return @res.send 'login-error ' + @req.query.error_description
    else if not @req.query.code
      return @res.redirect '/demo'

    fb.authenticate @req.query.code, ($err, result) =>

      if $err then return muninn.logMessage('error', String($err)) if muninn.showError($err)

      @req.session.access_token    = result.access_token
      @req.session.expires         = result.expires or 0

      if @req.query.state
        parameters                = JSON.parse(@req.query.state)
        parameters.access_token   = @req.session.access_token

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