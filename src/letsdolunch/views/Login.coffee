app = require('../app')
fb = require('../fb')

class app.views.Login extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("Login")
    @model.on "change", @render, this
    @render()

  render: ->
    @$el.html @template.render(@model.toJSON())
    this

  events:
    "click .login": "login"
    "click .logout": "logout"

  login: (e) ->
    $(document).trigger "login"
    false

  logout: (e) ->
    $(document).trigger "logout"
    false
