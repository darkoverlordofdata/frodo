app = require('../app')
fb = require('../fb')

class app.views.Revoke extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("Revoke")
    @render()

  render: ->
    @$el.html @template.render()
    this

  events:
    "click .revoke": "revoke"

  revoke: ->
    FB.api "/me/permissions", "delete", ->
      alert "Permissions revoked"
      FB.getLoginStatus()

    false

