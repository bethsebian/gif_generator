class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Successfully Logged In!"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Successfully Logged Out!"
    redirect_to root_path
  end
end
