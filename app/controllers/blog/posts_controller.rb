class Blog::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creater_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      error_message = @post.errors.full_messages
      flash.now[:alert] = error_message.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @creater = User.find(@post.creater_id)
    @comments = @post.comments
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
