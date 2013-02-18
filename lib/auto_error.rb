# core ext
require 'core_ext/proc_ext'

# asset pipeline deps
require 'handlebars_assets'
require 'coffee_script'

# other deps
require 'jquery-rails'
require 'haml'
require 'draper'
require 'exception_notification'

# lib
require 'auto_error/version'
require 'auto_error/config'
require 'auto_error/errors'
require 'auto_error/context_shorthand'
require 'auto_error/view_context'
require 'auto_error/auth_context'
require 'auto_error/engine'

module AutoError
  def self.setup!( app_config )
    AutoError::Config.send(:set_defaults)
    app_config.action_dispatch.rescue_responses["AutoError::Errors::Denied"] = :forbidden
    app_config.action_dispatch.rescue_responses["AutoError::Errors::NotFound"] = :not_found

    original_exceptions_app = app_config.exceptions_app || ActionDispatch::PublicExceptions.new(Rails.public_path)
    app_config.exceptions_app = ->(env) do
      # puts "Handling exception for #{env['action_controller.instance'].class}"
      controller_class = env['action_controller.instance'].class
      if controller_class.nil? || AutoError.constants.any? { |c| AutoError.const_get(c) == controller_class }
        # do not log/handle exception at all if the error is actually
        # IN auto_error :)
        original_exceptions_app.call(env)
      else
        env['auto_error.original_controller.instance'] = env['action_controller.instance']
        AutoError::ErrorsController.action(:show).call(env)
      end
    end
  end
end
