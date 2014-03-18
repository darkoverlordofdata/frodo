app = require('../app')

class app.lib.TemplateLoader

  constructor: ->
    @templates = {}

  load: (names, callback) ->
    deferreds = []
    $.each names, (index, name) =>
      if app.views[name]
        deferreds.push $.get "tpl/" + name.toLowerCase() + ".liquid", (template) =>
          @templates[name] = Liquid.Template.parse(template)
      else
        alert name + " not found"


    $.when.apply(null, deferreds).done callback


  # Get template by name from hash of preloaded templates
  get: (name) ->
    @templates[name]

