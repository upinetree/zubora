class UsersController < ApplicationController
  skip_before_action :authenticate, only: %i(new create)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to signin_url, notice: "You've Successfully Signed up."
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:screen_name, :email, :password ,:password_confirmation)
  end
end

