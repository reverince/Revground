class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def logged_in_user
    store_location
    unless logged_in?
      flash[:danger] = "계속하려면 로그인하세요"
      redirect_to login_url
    end
  end

end
