class App.AppError extends Backbone.Model

class App.AppErrors extends Backbone.Collection
  model: App.AppError
  name: 'app errors'
  url: -> App.rootAppErrorsPath
