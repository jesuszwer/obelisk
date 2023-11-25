class Blog::CommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.sender_id = current_user.username
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post)
    else
      error_message = @comment.errors.full_messages
      flash.now[:alert] = error_message.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
