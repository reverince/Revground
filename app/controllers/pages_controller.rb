class PagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @microposts = @user.microposts.paginate(page: params[:page])
      @micropost = current_user.microposts.build
    end
  end

  def about
  end

end
