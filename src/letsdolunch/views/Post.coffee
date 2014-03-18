app = require('../app')
fb = require('../fb')

class app.views.Post extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("Post")
    @render()

  render: ->
    @$el.html @template.render()
    this

  events:
    "click .post": "postMessage"

  postMessage: ->
    status =
      name: $(".itemName").val()
      link: $(".link").val()
      picture: $(".picture").val()
      caption: $(".caption").val()
      description: $(".description").val()

    FB.api "/me/feed", "post", status, (response) ->
      if response and response.id
        alert "Your post was published."
      else
        alert "Your post was not published."

    false
