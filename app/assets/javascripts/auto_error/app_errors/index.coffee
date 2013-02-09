#= require ./configure

#= require ./model
#= require ./views/base
#= require ./views/app_errors

$(document).ready ->
  $.ajaxSetup
    headers:
      'X-CSRF-Token': $("meta[name='csrf-token']").attr( 'content' )

  App.rootAppErrorsPath = $('#app_errors').data('url')
  new App.Views.AppErrors()
