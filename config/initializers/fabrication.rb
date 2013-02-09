if Rails.env.test?
  require 'fabrication'
  Fabrication.configure do |config|
    config.path_prefix = AutoError::Engine.root
  end
end
