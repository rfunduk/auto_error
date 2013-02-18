class AutoError::MainController < AutoError::ApplicationController
  before_filter :ensure_authenticated

  def index
    render layout: 'auto_error/application'
  end
end
