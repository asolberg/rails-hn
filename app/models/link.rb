class Link < ActiveRecord::Base
    
    has_many :votes
    belongs_to :user

    validates :title, presence: true
    validates :url, presence: true
    validates :description, presence: true, length: { minimum: 6 }

   
end
