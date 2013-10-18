class LinksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :update]



  def index
    if signed_in?
      @links = Link.joins('left join votes on links.id = votes.link_id').select("links.*, coalesce(sum(votes.value),0) as votes_total, sum(case votes.user_id when #{current_user.try(:id)} then votes.value else 0 end) as user_votes_total").group("links.id").order('votes_total DESC').paginate(page: params[:page], per_page: 10)
    else
      @links = Link.joins('left join votes on links.id = votes.link_id').select("links.*, coalesce(sum(votes.value),0) as votes_total, sum(case votes.user_id when null then votes.value else 0 end) as user_votes_total").group("links.id").order('votes_total DESC').paginate(page: params[:page], per_page: 10)
    end
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.where(id: params[:id]).first
  end

  def create
    @link = Link.new(link_params)
    if @link.save
        flash[:success] = "Link saved!"
        redirect_to root_path
    else
        # There was an error, re-render error partial will display
        render 'new'
    end

  end

  def update
    @link = Link.new
  end

  private

    def link_params
        params.require(:link).permit(:title, :url, :description)
    end
end
