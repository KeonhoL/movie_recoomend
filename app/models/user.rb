class User < ActiveRecord::Base
    belongs_to  :gender
    belongs_to  :job
    belongs_to  :emotion
    belongs_to  :category
    has_many    :reviews
    has_many    :posts
    has_many    :movies,    through:    :movielikeds
    has_many    :movielikeds
    has_many    :recommends
    validates :username, :presence => { :message => "ID를 입력해주세요" }
    validates :username, :uniqueness => { :message => "사용하고 있는 ID입니다.", :case_sensitive => false }
    validates :password, :length => { :minimum => 6, :too_short => "비밀번호는 6자 이상 입니다" }
end
