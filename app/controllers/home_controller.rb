class HomeController < ApplicationController

  def index
    @users = User.includes(:info).all
  end

end