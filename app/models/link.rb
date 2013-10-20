class Link < ActiveRecord::Base
    
    has_many :votes
    belongs_to :user

    validates :title, presence: true
    validates :url, presence: true
    validates :description, presence: true, length: { minimum: 6 }

    has_many :comments, as: :commentable

    def self.order_by_votes(current_user_id)
        current_user_id ||= "null"
        joins('left join votes on links.id = votes.link_id')
        .select("links.*, coalesce(sum(votes.value),0) as votes_total, " <<
        "sum(case votes.user_id when #{current_user_id} then votes.value "<<
        "else 0 end) as user_votes_total").group("links.id")
        .order('votes_total DESC').paginate(page: 1, per_page: 10)
    end


end
