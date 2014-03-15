app = require('../app')
fb = require('../fb')

class app.views.PostUI extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("PostUI")
    @render()

  render: ->
    @$el.html @template.render()
    this

  events:
    "click .post": "postMessage"

  postMessage: ->
    FB.ui
      method: "feed"
      name: "Sociogram Application"
      link: "http://coenraets.org/blog/sociogram"
      picture: "http://coenraets.org/sociogram/img/sociogram.jpg"
      caption: "by Christophe Coenraets"
      description: "Sociogram is a simple application that shows how to use the Facebook JavaScript SDK and the Graph API."
    , (response) ->
      if response and response.id
        alert "Your post was published."
      else
        alert "Your post was not published."

    false
