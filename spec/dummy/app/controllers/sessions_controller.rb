class SessionsController < ApplicationController

  def new
  end

  def create
    email = params[:email].downcase
    password = params[:password]
    admin = Administrator.where( email: email ).first
    if admin.authenticate( password )
      session[:admin_id] = admin.id
      redirect_to root_path
    else
      flash[:error] = "Incorrect."
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
