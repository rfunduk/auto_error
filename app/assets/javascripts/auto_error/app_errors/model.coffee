class AutoErrorApp.AppError extends Backbone.Model

class AutoErrorApp.AppErrors extends Backbone.Collection
  model: AutoErrorApp.AppError
  name: 'app errors'
  url: -> AutoErrorApp.rootAppErrorsPath
