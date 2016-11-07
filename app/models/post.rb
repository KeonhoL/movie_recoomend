class Post < ActiveRecord::Base
    belongs_to :bulletin
    belongs_to :user
    has_many :comments, dependent: :destroy
end
