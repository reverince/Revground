class PagesController < ApplicationController

  def home
    @microposts = current_user.microposts.build if logged_in?
  end

  def about
  end

end
