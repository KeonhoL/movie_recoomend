class UserController < ApplicationController
  def signup
    @location = Location.all
    @weather = Weather.all
    @sex  = Gender.all
    @cate = Category.all
  end
  
  def mypage
    @user = User.find(params[:id])
  end
  
  def signup_complete
    u = User.new
    u.username    = params[:username]
    u.age         = params[:age]
    u.gender_id   = params[:gender]
    u.category_id = params[:category]
    u.location_id = params[:location]
    u.weather_id = params[:weather]
    if params[:password] == params[:retype_password]
      u.password = params[:password]
      if u.save
        flash[:alert] = "성공적으로 가입되었습니다."
        redirect_to "/home/index"
      else
        flash[:alert] = u.errors.values.flatten.join(' ')
        redirect_to :back
      end
    else
      flash[:alert] = "비밀번호가 틀립니다."
      redirect_to :back
    end
  end
  
  def login
  end

  def login_complete
    user = User.where(username: params[:username])[0]
    if user.nil?
      flash[:alert] = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
      redirect_to :back
    elsif user.password != params[:password]
      flash[:alert] = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
      redirect_to :back
    else
      session[:user_id] = user.id
      flash[:alert] = "성공적으로 로그인하였습니다."
      redirect_to "/home/index"
    end
  end

  def logout_complete
    reset_session
    flash[:alert] = "성공적으로 로그아웃하였습니다."
    redirect_to "/home/index"
  end
end
