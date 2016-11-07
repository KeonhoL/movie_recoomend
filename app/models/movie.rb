class Movie < ActiveRecord::Base
    has_many    :reviews
    has_many    :users,    through:    :movielikeds
    has_many    :movielikeds
    belongs_to  :category
    validates :title, :presence => { :message => "제목을 반드시 입력하셔야 합니다." }
end
