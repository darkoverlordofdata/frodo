app = require('../app')
fb = require('../fb')

class app.views.Error extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("Error")
    @render()

  render: ->
    @$el.html @template.render()
    this

  events:
    "click .retry": "retry"

  retry: ->
    Backbone.history.loadUrl Backbone.history.fragment
