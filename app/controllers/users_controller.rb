class UsersController < ApplicationController
  # before_filter :sanitize_user_params, only: [:create]

  def new
    @user = User.new
  end

  def create
    # byebug
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Account successfully created."
      redirect_to @user
    else
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

private

  def user_params
    params[:user][:role] = params[:user][:role].to_i
    params.require(:user).permit(:username, :password, :password_confirmation, :role)
    # x[:role] = x[:role].to_i
    # x
  end

  def sanitize_user_params
  end
end
