class AppError extends AutoErrorApp.Views.PolledItem
  template: AutoErrorApp.Templates.app_error
  events:
    'click a.show_backtrace': 'toggleBacktrace'
    'click a.remove': 'destroy'
  render: ->
    json = @model.toJSON()
    json.prettyData = []
    json.backtrace = @model.get('backtrace').replace( /\n/g, "<br/>" )
    for k, v of json.data
      json.prettyData.push "#{k}: <tt>#{v}</tt>"
    json.prettyData = json.prettyData.join("<br/>")
    json.timestamp = moment(json.created_at).format( "YYYY-MM-DD[<br/>at] h:mma" )
    @$el.html( @template( json ) )
    return @
  toggleBacktrace: ->
    link = @$('a.show_backtrace')
    @$('.backtrace').reveal()
  destroy: ->
    @model.destroy()
    @remove()

class AppErrorsList extends AutoErrorApp.Views.PollingList

class AutoErrorApp.Views.AppErrors extends Backbone.View
  el: 'body'
  initialize: ->
    @errors = new AppErrorsList(
      el: @$('#app_errors table')
      reset: false
      viewClass: AppError
      collectionClass: AutoErrorApp.AppErrors
    )
