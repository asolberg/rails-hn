class LinksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :update]

  def index
      @links = Link.order_by_votes current_user.try(:id)
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.where(id: params[:id]).take
    @commentable = @link
    @comments = @commentable.comments.includes(:user).order("created_at ASC")
    @comment = Comment.new
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
