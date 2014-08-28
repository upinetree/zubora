class SessionsController < ApplicationController
  skip_before_action :authenticate

  def new
    redirect_to root_url if current_user
  end

  def create
    user = User.find(env["omniauth.auth"]["uid"])
    session[:user_id] = user.id
    redirect_to expenses_url, notice: "Signed in!"
  end

  def destroy
    sign_out
    redirect_to signin_url, notice: "Signed out!"
  end

  def failure
    redirect_to signin_url, alert: "Authentication failed, please try again."
  end
end
