module AutoError
  class AppErrorsController < ApplicationController
    before_filter :ensure_authenticated

    def index
      @errors = AppError.unresolved
      render json: @errors.map { |ae| AppErrorDecorator.new(ae).as_json }
    end

    def destroy
      @error = AppError.find( params[:id] )
      @error.resolved_at = Time.now
      @error.save
      render json: { ok: true }
    end
  end
end
