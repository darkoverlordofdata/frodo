module.exports = class app

class app.models
class app.views
class app.controllers
class app.lib

require './lib/TemplateLoader'
require './lib/DOMFileSystem'

require './controllers/Application'
require './controllers/Router'

require './models/Person'
require './models/PersonCollection'

require './views/Error'
require './views/Feed'
require './views/Friends'
require './views/Login'
require './views/Person'
require './views/Post'
require './views/PostUI'
require './views/Revoke'
require './views/Shell'
require './views/Welcome'


