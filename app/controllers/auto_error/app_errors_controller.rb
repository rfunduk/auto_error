class AutoError::AppErrorsController < AutoError::ApplicationController
  before_filter :ensure_authenticated

  def index
    @errors = AutoError::AppError.unresolved
    render json: @errors.map { |ae| AutoError::AppErrorDecorator.new(ae).as_json( @h ) }
  end

  def destroy
    @error = AutoError::AppError.find( params[:id] )
    @error.resolved_at = Time.now
    @error.save
    render json: { ok: true }
  end
end
