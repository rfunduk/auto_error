module AutoError

  # Convenience methods added to ApplicationController.
  module ContextShorthand
    def add_error_context( context )
      AutoError::AppError.add_context( env, context )
    end
    def clear_error_context
      AutoError::AppError.clear_context!( env )
    end
  end

  ActionController::Base.send :include, AutoError::ContextShorthand

end
