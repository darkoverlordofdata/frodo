app = require('../app')
fb = require('../fb')

class app.controllers.Router extends Backbone.Router

  routes:
    "": "welcome"
    me: "me"
    "me/friends": "myfriends"
    "person/:id": "person"
    "person/:id/friends": "friends"
    "person/:id/mutualfriends": "mutualfriends"
    "person/:id/feed": "feed"
    revoke: "revoke"
    post: "post"
    postui: "postui"

  initialize: ->
    
    # Caching the Welcome View
    @welcomeView = new app.views.Welcome(model: fb.user)

  welcome: ->
    $("#content").html @welcomeView.el

  me: ->
    @person "me"

  myfriends: ->
    @friends "me"

  person: (id) ->

    $("#content").html "<div class=\"breadcrumb api\">FB.api(\"/" + id + "\");</div>"
    try
      FB.api "/" + id, (response) =>
        if response.error
          @showErrorPage()
        else
          $("#content").append new app.views.Person(model: new app.models.Person(response)).el

    catch e
      @showErrorPage()

  friends: (id) ->

    $("#content").html "<div class=\"breadcrumb api\">FB.api(\"/" + id + "/friends\");</div>"
    try
      FB.api "/" + id + "/friends?limit=20", (response) =>
        if response.error
          @showErrorPage()
        else
          $("#content").append new app.views.Friends(model: new Backbone.Model(response)).el

    catch e
      @showErrorPage()

  mutualfriends: (id) ->

    $("#content").html "<div class=\"breadcrumb api\">FB.api(\"/" + id + "/mutualfriends\");</div>"
    try
      FB.api "/" + id + "/mutualfriends?limit=20", (response) =>
        if response.error
          @showErrorPage()
        else
          $("#content").append new app.views.Friends(model: new Backbone.Model(response)).el

    catch e
      @showErrorPage()

  feed: (id) ->

    $("#content").html "<div class=\"breadcrumb api\">FB.api(\"/" + id + "/feed\");</div>"
    try
      FB.api "/" + id + "/feed?limit=20", (response) =>
        if response.error
          @showErrorPage()
        else
          $("#content").append new app.views.Feed(model: new Backbone.Model(response)).el

    catch e
      @showErrorPage()

  post: ->
    $("#content").html "<div class=\"breadcrumb api\">FB.api(\"/me/feed\", \"post\", data);</div>"
    $("#content").append new app.views.Post().el

  postui: ->
    $("#content").html "<div class=\"breadcrumb api\">FB.ui();</div>"
    $("#content").append new app.views.PostUI().el

  revoke: ->
    $("#content").html "<div class=\"breadcrumb api\">FB.api(\"/me/permissions\", \"delete\");</div>"
    $("#content").append new app.views.Revoke().el

  showErrorPage: ->
    $("#content").append new app.views.Error().el

