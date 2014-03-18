app = require('../app')
fb = require('../fb')

class app.views.Shell extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("Shell")
    @render()

  render: ->
    @$el.html @template.render(@model.toJSON())
    new app.views.Login(
      model: @model
      el: "#login"
    )
    this

  events:
    "mousedown li": "mouseDown"
    "mouseup li": "mouseUp"
    "click .btn-login": "login"

  mouseDown: (e) ->
    $(e.currentTarget).addClass "active"

  mouseUp: ->
    $("li").removeClass "active"

  login: ->
    $(document).trigger "login"
    false

