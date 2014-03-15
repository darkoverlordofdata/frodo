#+--------------------------------------------------------------------+
#| frodo.coffee
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
#	Frodo Lives!
#
muninn = require("muninn")
muninn.init __dirname
fb = require("fb")
Facebook = require('facebook-node-sdk')
#
# Facebook Config
#
fb.options
  appId: muninn.config.fb.appId
  appSecret: muninn.config.fb.appSecret
  redirectUri: muninn.config.fb.redirectUri

#
# Facebook Authentication Helper
#
fb.authenticate = ($code, $next) ->

  fb.api "oauth/access_token",
    client_id: fb.options("appId")
    client_secret: fb.options("appSecret")
    redirect_uri: fb.options("redirectUri")
    code: $code
  , ($result) ->

    return $next('Unable to authenticate') if not $result
    return $next($result.error) if $result.error

    fb.api "oauth/access_token",
      client_id: fb.options("appId")
      client_secret: fb.options("appSecret")
      grant_type: "fb_exchange_token"
      fb_exchange_token: $result.access_token
    , ($result) ->

      return $next('Unable to authenticate') if not $result
      return $next($result.error) if $result.error

      $next null, $result



middleware = ($req, $res, $next) ->

  muninn.logMessage 'debug', "MIDDLEWARE"
  $next()

muninn.start Facebook.middleware(appId: muninn.config.fb.appId, secret: muninn.config.fb.appSecret), middleware

