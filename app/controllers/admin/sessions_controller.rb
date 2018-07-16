class Admin::SessionsController < ApplicationController
  def new
    redirect_to request.referer || admin_users_path if admin_logged_in?
  end

  def create
    @admin = Admin.find_by(username: params[:session][:username])

    if @admin&.authenticate?(params[:session][:password])
      log_in @admin
      flash[:success] = 'Log in successfully'
      redirect_to admin_users_path
    else
      flash[:danger] = 'Invalid username or password'
      redirect_to admin_login_path
    end
  end

  def destroy
    log_out
    flash[:success] = 'Log out successfully'
    redirect_to admin_login_path
  end
end
