class AppError extends App.Views.PolledItem
  template: App.Templates.app_error
  events:
    'click a.show_backtrace': 'toggleBacktrace'
    'click a.remove': 'destroy'
  render: ->
    json = @model.toJSON()
    json.prettyData = []
    for k, v of json.data
      json.prettyData.push "#{k}: #{v}"
    json.prettyData = json.prettyData.join("\n")
    json.timestamp = moment(json.created_at).format( "YYYY-MM-DD[<br/>at] h:mma" )
    @$el.html( @template( json ) )
    return @
  toggleBacktrace: ->
    link = @$('a.show_backtrace')
    bt = @$('.backtrace')
    if bt.is(':visible')
      bt.hide()
      link.text('show backtrace...')
    else
      bt.html( @model.get('backtrace').replace( /\n/g, "<br/>" ) ).show()
      link.text('hide backtrace...')
  destroy: ->
    @model.destroy()
    @remove()

class AppErrorsList extends App.Views.PollingList

class App.Views.AppErrors extends Backbone.View
  el: 'body'
  initialize: ->
    @errors = new AppErrorsList(
      el: @$('#app_errors table')
      reset: false
      viewClass: AppError
      collectionClass: App.AppErrors
    )
