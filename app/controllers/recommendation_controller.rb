class RecommendationController < ApplicationController 
    def index
        @movie_count = Movie.count
    end
    
    def action  
        u = User.all
        mine = User.find(session[:user_id])
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
            
            if user.location == mine.location
                locationpoint = 1
            else
                locationpoint = 0
            end
            
            if user.weather == mine.weather
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
        
        @re = Recommend.all
    end
end
