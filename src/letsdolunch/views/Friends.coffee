app = require('../app')
fb = require('../fb')

class app.views.Friends extends Backbone.View

  initialize: ->
    @template = fb.templateLoader.get("Friends")
    @model.on "change", @render, this
    @render()

  render: ->
    @$el.html @template.render(@model.toJSON())
    this

  events:
    "click .next": "next"
    "click .previous": "previous"

  next: ->
    @fetch @model.get("paging").next
    false

  previous: ->
    @fetch @model.get("paging").previous
    false

  fetch: (url) ->
    self = this
    $.ajax(
      url: url
      dataType: "json"
    ).done((response) ->
      self.model.set response
    ).fail (e) ->
      alert "Error fetching data"

