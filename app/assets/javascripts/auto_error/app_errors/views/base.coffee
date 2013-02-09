class App.Views.PolledItem extends Backbone.View
  tagName: 'tr'
  initialize: ->
    @model.on 'change', @render, @

class App.Views.PollingList extends Backbone.View
  events:
    'click .poller a': 'togglePolling'
  initialize: ->
    @collection = new @options.collectionClass( [] )
    @spinner = @$('tfoot .poller .spinner')
    @polling = false
    @body = @$('tbody')
    @emptyMessage = @body.html().replace(/[\r\n]\s+/g, '')
    @collection.on 'remove', @remove, @
    @collection.on 'add', @render, @
    @collection.fetch( update: true )
    @views = {}
  remove: ( m ) ->
    @views[m.id] = null
    @render()
  render: ->
    if @collection.isEmpty()
      message = $(@emptyMessage)
      message.find('p.loading_message').text( "No #{@collection.name}!" )
      @body.html( message )
    else
      @body.find('p.loading_message').parents('tr').remove()
      @collection.each (m) =>
        return if @views[m.id]
        v = new @options.viewClass( model: m )
        @views[m.id] = v
        @body.prepend v.render().el
    @$('tfoot p.total strong').text( @collection.length )
  togglePolling: (e) ->
    link = $(e.target)
    if @polling == false
      @polling = true
      @poll()
      link.text( 'stop polling' )
    else
      @polling = false
      link.text( 'start polling' )
      @spinner.hide()
  poll: ->
    if @polling
      startTime = new Date().getTime()
      @spinner.fadeIn()
      args =
        update: true
        success: =>
          setTimeout( _.bind(@poll, @), 2000 ) if @polling
          setTimeout(
            _.bind( @spinner.fadeOut, @spinner )
            Math.max( (new Date().getTime() - startTime), 500 )
          )
      @collection.fetch args
