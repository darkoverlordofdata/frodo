    code = req.query.code

    if req.query.error
      # user might have disallowed the app
      return res.send 'login-error ' + req.query.error_description
    else if not code
      return res.redirect('/')

    step(
      () ->
        fb.napi('oauth/access_token', {
          client_id:      fb.options('appId'),
          client_secret:  fb.options('appSecret'),
          redirect_uri:   fb.options('redirectUri'),
          code:           code
        }, this)

      (err, result) ->
        if(err) then throw(err)
        fb.napi('oauth/access_token', {
          client_id:          fb.options('appId'),
          client_secret:      fb.options('appSecret'),
          grant_type:         'fb_exchange_token',
          fb_exchange_token:  result.access_token
        }, this)

      (err, result) ->
        if(err) then return next(err)

        req.session.access_token    = result.access_token
        req.session.expires         = result.expires || 0

        if(req.query.state)
          parameters              = JSON.parse(req.query.state)
          parameters.access_token = req.session.access_token

          console.log(parameters)

          fb.api '/me/' + config.facebook.appNamespace +':eat', 'post', parameters , (result) ->
            console.log(result)
            if(!result || result.error)
              return res.send(500, result || 'error')
            return res.redirect('/')

        else
          return res.redirect('/')
    )

