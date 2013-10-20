class VotesController < ApplicationController
    before_action :signed_in_user, only: [:update]

    def new
    end

    def show
    end

    def update
            @vote = Vote.record_user_vote(params[:link_id], current_user.id, params[:id])
            
            respond_to do |format|
                format.html { redirect_to(root_path) }
                format.json { render json: {success: true, redirect: false} }
            end

            rescue ActiveRecord::RecordInvalid
                respond_to do |format|
                    format.html do
                        flash[:error] = 'Vote error'
                        redirect_to(root_path)
                    end
                    format.json { render json: {success: false, redirect: false} }
                end
            end

    end
