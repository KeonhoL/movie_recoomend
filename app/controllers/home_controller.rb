class HomeController < ApplicationController
  def index
    if !session[:user_id].nil?
      @u = User.find(session[:user_id])
    else
    end
  end
end
