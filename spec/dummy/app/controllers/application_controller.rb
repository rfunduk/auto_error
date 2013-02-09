class ApplicationController < ActionController::Base
  include AutoError::Errors
  include ApplicationHelper

  helper :all

  protect_from_forgery with: :exception

  protected

  def ensure_authenticated
    if current_admin.nil?
      redirect_to new_session_path
      return
    end
  end
end
