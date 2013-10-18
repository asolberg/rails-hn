class VotesController < ApplicationController
    before_action :signed_in_user, only: [:update]

    def new
    end

    def show
    end

    def update
            @vote = Vote.find_or_initialize_by( link_id: params[:link_id], user_id: current_user.id)
            case params[:id].to_i
            when 1
                @vote.value = -1
            when 2
                @vote.value = 1
            when 0
                @vote.value = 0
            end
            @vote.save

        respond_to do |format|
            format.html { redirect_to(root_path) }
            format.json { render json: {success: true, redirect: false} }
        end

    end

end
