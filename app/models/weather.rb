class Weather < ActiveRecord::Base
    has_many    :users
end
