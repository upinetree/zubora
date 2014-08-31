class UsersController < ApplicationController
  skip_before_action :authenticate, only: %i(new create)

  before_action :set_user, only: [:edit, :update]

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

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_url, notice: "Your profile has been successfully updated."
    else
      render action: 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:screen_name, :email, :password ,:password_confirmation)
  end

  def set_user
    @user = current_user
  end
end

