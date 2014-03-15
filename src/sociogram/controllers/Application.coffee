app = require('../app')

class app.controllers.Application

  constructor: ->

    @user = null
    @shell = null
    @router = null
    @models = {}
    @views = {}
    @templateLoader = new app.lib.TemplateLoader()

