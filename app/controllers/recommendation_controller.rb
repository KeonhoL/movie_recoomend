class RecommendationController < ApplicationController 
    def index
        @movie_count = Movie.count
        @user_count = User.count
        @emo = Emotion.all
    end
    
    def action  
        Recommend.destroy_all
        u = User.all
        mine = User.find(session[:user_id])
        mine.emotion_id = params[:emotion]
        mine.save
        
        u.delete(mine[0])
        
        age2 = mine.age
        u.each do |user|
            next if user.id == mine.id
            age1 = user.age / 10
            
            agepoint = 0
            genderpoint = 0
            categorypoint = 0
            locationpoint = 0
            weatherpoint = 0
            total = 0
            if age1 == age2
                agepoint = 1
            else
                agepoint = 0
            end
            
            if user.gender == mine.gender
                genderpoint = 1    
            else
                genderpoint = 0
            end
            
            if user.category == mine.category
                categorypoint = 1 
            else
                categorypoint = 0
            end
            
            if user.job == mine.job
                locationpoint = 1
            else
                locationpoint = 0
            end
            
            if user.emotion == mine.emotion
                weatherpoint = 1
            else
                weatherpoint = 0
            end
            
            total = agepoint + genderpoint + categorypoint + locationpoint + weatherpoint
            r = Recommend.new
            r.user_id = user.id
            r.compare = total / 5.0
            r.save
        end
        
        @re = Recommend.all.sort_by(&:compare).reverse.first(3)
    end
end
