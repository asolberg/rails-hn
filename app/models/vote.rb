class Vote < ActiveRecord::Base
    belongs_to :user
    belongs_to :link

    def self.record_user_vote(link_id, user_id, vote_code)
        vote = find_or_initialize_by( link_id: link_id, user_id: user_id)
        case vote_code.to_i
            when 1
                vote.value = -1
            when 2
                vote.value = 1
            when 0
                vote.value = 0
            end
            vote.save
    end

    def votes_with_totals
    end
end
