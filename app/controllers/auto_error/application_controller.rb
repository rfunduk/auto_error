class AutoError::ApplicationController < ActionController::Base
  include AutoError::ApplicationHelper
  helper :all

  protected

  def ensure_authenticated
    context = AutoError::AuthContext.new(env)
    raise AutoError::Errors::Denied unless AutoError::Config.auth_with.call(context)
  end
end
