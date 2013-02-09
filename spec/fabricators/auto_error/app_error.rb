Fabricator( :app_error, class_name: "AutoError::AppError" ) do
  group 'agroup'
  klass 'ArgumentError'
  controller 'SomeController'
  action 'some_action'
  message 'The message.'
  backtrace "The\nBacktrace"
  data { Hash.new }
end
