require "auto_error"

AutoError::Config.setup do |config|
  config.data_handlers[:x] = ->( number ) do
    link_to( "##{number}", root_path( number: number ) )
  end
end
