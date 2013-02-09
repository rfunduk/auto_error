module ApplicationHelper

  def current_admin
    @current_admin ||= Administrator.find_by_id( session[:admin_id] )
  end

end
