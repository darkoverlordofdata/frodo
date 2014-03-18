app = require('../app')

class app.models.Person extends Backbone.Model

  defaults:
    id: ""
    name: ""
    first_name: ""
    last_name: ""
    gender: ""
    username: ""
    link: ""
    locale: ""
    timezone: ""

