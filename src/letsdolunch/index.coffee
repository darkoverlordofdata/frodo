app = require('./app')
fb = require('./fb')

# Load the SDK Asynchronously
do (d = document) ->

#  js = undefined
  id = "facebook-jssdk"
  ref = d.getElementsByTagName("script")[0]
  return  if d.getElementById(id)
  js = d.createElement("script")
  js.id = id
  js.async = true
  js.src = "//connect.facebook.net/en_US/all.js"
  ref.parentNode.insertBefore js, ref


window.fbAsyncInit = ->

  FB.Event.subscribe "auth.statusChange", (response) ->
    $(document).trigger "fbStatusChange", response

  FB.init
    appId: "1478930342328388" # App ID
    channelUrl: "//localhost/channel.html" # Channel File
    status: true # check login status
    cookie: true # enable cookies to allow the server to access the session
    xfbml: true # parse XFBML

$(document).on "ready", ->
  fb.user = new app.models.Person() # Holds the authenticated Facebook user
  # Load HTML templates for the app
  fb.templateLoader.load [
    "Shell"
    "Welcome"
    "Login"
    "Person"
    "Friends"
    "Feed"
    "Post"
    "PostUI"
    "Error"
    "Revoke"
  ], ->
    fb.shell = new app.views.Shell(el: "#shell", model: fb.user)
    fb.router = new app.controllers.Router()
    Backbone.history.start()


$(document).on "fbStatusChange", (event, data) ->
  if data.status is "connected"
    FB.api "/me", (response) ->
      fb.user.set response # Store the newly authenticated FB user

  else
    fb.user.set fb.user.defaults # Reset current FB user

$(document).on "logout", ->
  FB.logout()
  false


$(document).on "login", ->
  FB.login (->) , scope: "publish_actions"
  false

