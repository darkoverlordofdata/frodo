app = require('../app')
fb = require('../fb')

class app.views.Welcome extends Backbone.View

  initialize: ->
    self = this
    @template = fb.templateLoader.get("Welcome")
    @model.on "change", @showHideButtons, this
    @render()

  render: ->
    @$el.html @template.render()
    @showHideButtons()
    this

  showHideButtons: ->
    if @model.get("id") isnt ""
      $(".btn-login", @el).addClass "hidden"
      $(".btn-profile", @el).removeClass "hidden"
    else
      $(".btn-login", @el).removeClass "hidden"
      $(".btn-profile", @el).addClass "hidden"

