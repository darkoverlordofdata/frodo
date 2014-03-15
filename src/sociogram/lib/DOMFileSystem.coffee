app = require('../app')

class app.lib.DOMFileSystem

  readTemplateFile: ($template) ->

    if (el = $('#'+$template))?
      el.text()
    else
      throw Liquid.FileSystemError("Template not found: #{$template}")

Liquid.Template.fileSystem = new app.lib.DOMFileSystem


