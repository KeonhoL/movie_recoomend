class HomeController < ApplicationController
  def index
    if !session[:user_id].nil?
      @u = User.find(session[:user_id])
    else
    end
    @posts = Bulletin.second.posts
    @movie = Movie.all.sample(3)
    @best_movie = Movie.first
  end
end
