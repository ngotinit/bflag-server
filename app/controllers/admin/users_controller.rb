class Admin::UsersController < ApplicationController
  before_action :require_admin_log_in
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.search(params[:search]).order('id')
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

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
