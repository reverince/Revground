class PagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @microposts = @user.microposts.paginate(page: params[:page])
    end
  end

  def about
  end

end
