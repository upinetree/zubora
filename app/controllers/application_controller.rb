class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  helper_method :current_user

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      sign_out
    end
  end

  def authenticate
    unless current_user
      redirect_to signin_path
    end
  end

  private

  def sign_out
    @current_user = nil
    session[:user_id] = nil
  end
end
