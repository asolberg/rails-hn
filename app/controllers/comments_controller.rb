class CommentsController < ApplicationController
  before_action :load_commentable

  def index
    @comments = @commentable.comments.order()
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    # received_params = params.permit!
    # use_params = received_params["comment"]
    # puts "PARAMETERS RECIEVED" + use_params.to_s
    @comment = @commentable.comments.new(params.require(:comment).permit(:content))
    @comment.user_id = current_user.id
    @comment.save
    respond_to do |format|
      format.html {redirect_to @commentable,  notice: "Comment created."}
      format.js
    end
end


  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
end
end
