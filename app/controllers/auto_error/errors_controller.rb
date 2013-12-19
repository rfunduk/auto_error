class AutoError::ErrorsController < AutoError::ApplicationController

  def show
    # fix PATH_INFO to be the actual request path, and not /500
    env['PATH_INFO'] = env['ORIGINAL_FULLPATH']

    # reset action_controller.instance to the original controller
    # that caused the exception
    env['action_controller.instance'] = env.delete('auto_error.original_controller.instance')
    @controller = env['action_controller.instance']

    @exception       = env['action_dispatch.exception']
    @status_code     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]

    @status_code = 500 unless [403, 404].include?(@status_code)

    if @status_code == 500
      @request = @controller.request
      @params = @request.filtered_parameters.symbolize_keys
      controller = "#{@params[:controller].camelize}Controller" rescue 'N/A'
      action = @params[:action] || 'N/A'
      where = { controller: controller, action: action }
      data = {
        path: @request.fullpath.split('?').first,
        method: @request.method,
        ip: @request.remote_ip,
        params: @params.except( *(%w{
          controller action format _method only_path
        }.map(&:to_sym) ) )
      }
      # Rails.logger.error [controller,action, where, data].map(&:inspect).join("\n")
      AutoError::AppError.log!( env, @exception, where, data )
    end

    instance_exec( *[@status_code], &AutoError::Config.error_template_renderer )

  rescue => explosion
    Rails.logger.error "\nAutoError exploded while handling an exception: #{@exception.inspect}\nHere's the error: #{explosion.inspect}\n"
  end

end
