app = require('../app')
fb = require('../fb')

class app.views.Person extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("Person")
    @model.on "change", @render, this
    @render()

  render: ->
    @$el.html @template.render(@model.toJSON())
    this

