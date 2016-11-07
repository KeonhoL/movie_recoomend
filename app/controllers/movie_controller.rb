require 'nokogiri'
require 'open-uri'

class MovieController < ApplicationController
  before_action :login_check
  skip_before_action  :login_check, :only => [:list, :list_complete, :show]
  
  def list
    i = params[:movie]
    if !params[:movie].nil?
     @m = Movie.where("title LIKE ?", "%#{i}%")
    else
    end
  end
  
  def delete_review_complete
    comment = Review.find(params[:id])
    if comment.user_id == session[:user_id]
      comment.destroy
      flash[:alert] = "댓글이 삭제되었습니다."
      redirect_to "/movie/show/#{comment.movie_id}"
    else
      flash[:alert] = "해당 댓글의 삭제 권한이 없습니다."
      redirect_to :back
    end
  end
  
  def liked_complete
    movie = Movie.find(params[:id])
    user = User.where(id: session[:user_id])[0]
    like = Movieliked.new
    like.movie_id = movie.id
    like.user_id = user.id
    like.liked = true
    like.save
    redirect_to "/movie/show/#{like.movie.id}"
  end
  
  def liked_delete_complete
    movie = Movie.find(params[:id])
    user = User.where(id: session[:user_id])[0]
    like = Movieliked.where("movie_id = #{movie.id}", "user_id=#{user.id}")
    like.first.destroy
    flash[:alert] = "댓글이 삭제되었습니다."
    redirect_to "/user/mypage/#{user.id}"
  end
  
  def list_complete
    @m = params[:movie]
   # session[:somekey] = @m
    redirect_to :back, movie: @m
  end
  
  def delete_complete
    movie = Movie.find(params[:id])
    movie.destroy
    flash[:alert] = "삭제되었습니다."
    redirect_to "/movie/list"
  end
  
  def list_category
  end

  def show
    @movie = Movie.find(params[:id])
    @comment_writer = User.where(id: session[:user_id])[0]
    @like = Movieliked.where("movie_id = #{@movie.id}", "user_id=#{@comment_writer.id}")
  end

  def write
    @c = Category.all   
  end

  def write_complete
    m = Movie.new
    m.title = params[:title]
    m.category_id = params[:category]
    m.director = params[:director]
    m.actor_one = params[:actor]
    m.img_url   = params[:img_url]
    m.score     = params[:score].to_f
    if m.save
      flash[:alert] = "저장되었습니다."
      redirect_to "/movie/show/#{m.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def edit
    @c = Category.all
    @movie = Movie.find(params[:id])
  end

  def edit_complete
    m = Movie.find(params[:id])
    m.title = params[:title]
    m.category_id = params[:category]
    m.director = params[:director]
    m.actor_one = params[:actor]
    m.img_url   = params[:img_url]
    m.score     = params[:score].to_f
    if m.save
      flash[:alert] = "수정되었습니다."
      redirect_to "/movie/show/#{m.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end
  
  def get_movie
      90100.downto(90000) do |c|
      doc = Nokogiri::HTML(open("http://movie.daum.net/moviedb/main?movieId=#{c}")) 
      m = Movie.new
      doc.css(".subject_movie//.tit_movie").each do |x|
        m.title = x.inner_text
      end
      @a = doc.css("dl//dd").first.inner_text.split("/")
      @b = ["드라마","액션", "스릴러", "공포", "범죄", "판타지", "전쟁", "애니메이션", "코미디", "멜로", "미스터리", "SF", "사극", "다큐멘터리", "뮤지컬", "성인물", "기타"]
      @a.each do |a|
        @b.each do |b|
          if a == b # 2중 반복문 카 테고 리 검사
            a = b
          else
            a = Category.last.movie_category
          end
        end
      end
 
      m.category = Category.find_by_movie_category(@a.first)
      
      if !m.category
        m.category =  Category.last
      end
      if doc.css("dl//dd//a")[0].nil?
      else
        m.director = doc.css("dl//dd//a")[0].inner_text
      end
      if doc.css("dl//dd//a")[1].nil?
      else
        m.actor_one = doc.css("dl//dd//a")[1].inner_text
      end
      if doc.css("dl//dd//a")[2].nil?
      else
        m.actor_two = doc.css("dl//dd//a")[2].inner_text
      end
      if doc.css("dl//dd//a")[3].nil?
      else
        m.actor_three = doc.css("dl//dd//a")[3].inner_text
      end
      m.img_url = doc.at_xpath('//*[@class="area_poster thumb_noimage bg_noimage"]//img/@src').to_s
      m.score = doc.css(".emph_grade").first.inner_text
      m.save
    end
  end
  
  def delete_movie
    m = Movie.all
    m.each do |c|
      c.destroy
    end
  end
  
  def write_review_complete 
    r = Review.new
    r.user_id = session[:user_id]
    r.movie_id = params[:movie_id]
    r.content = params[:comment_content]
    r.save
    
    flash[:alert] = "새 댓글을 달았습니다."
    redirect_to "/movie/show/#{r.movie_id}"
  end
end
