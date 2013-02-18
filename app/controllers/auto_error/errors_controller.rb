class AutoError::ErrorsController < AutoError::ApplicationController

  def show
    # reset action_controller.instance to the original controller
    # that caused the exception
    env['action_controller.instance'] = env.delete('auto_error.original_controller.instance')

    @exception       = env['action_dispatch.exception']
    @status_code     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    @params          = env['action_dispatch.request.parameters'].symbolize_keys

    @status_code = 500 unless [403, 404].include?(@status_code)

    if @status_code == 500
      controller = "#{@params[:controller].camelize}Controller" rescue 'N/A'
      action = @params[:action] || 'N/A'
      where = { controller: controller, action: action }
      data = {
        path: env['REQUEST_URI'],
        method: env['REQUEST_METHOD'],
        ip: env['REMOTE_ADDR']
      }
      AutoError::AppError.log!( env, @exception, where, data )
    end

    AutoError::Config.error_template_renderer.bind(self).( @status_code )
  end

end
