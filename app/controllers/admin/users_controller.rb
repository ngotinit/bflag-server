class Admin::UsersController < ApplicationController
  before_action :require_admin_log_in
  before_action :set_user, only: %i[show destroy]

  def index
    @users = User.search(params[:search]).order('id')
  end

  def show; end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :first_name,
      :last_name,
      :password
    )
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
