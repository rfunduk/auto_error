module AutoError
  class Engine < ::Rails::Engine
    engine_name 'AutoError'
    isolate_namespace AutoError

    config.exceptions_app = ->(env) { }

    config.generators do |g|
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :fabrication
    end

    initializer 'auto_error.assets.precompile' do |app|
      app.config.assets.precompile += %w( auto_error.js auto_error.css )
    end
  end
end
