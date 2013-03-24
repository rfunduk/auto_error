class AutoError::ApplicationController < ::ApplicationController
  include AutoError::ApplicationHelper
  helper :all

  protected

  def ensure_authenticated
    @h = AutoError::HelperContext.new( env )

    # raise unless the auth_with helper returns a truthy value
    # this way we can let the user access their own auth logic
    unless AutoError::Config.auth_with.(@h)
      raise AutoError::Errors::Denied
    end
  end
end
