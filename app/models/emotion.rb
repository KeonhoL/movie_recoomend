class Emotion < ActiveRecord::Base
    has_many    :users
end
