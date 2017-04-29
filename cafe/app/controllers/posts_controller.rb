class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@posts = Post.all.order(updated_at: :desc)
  end

  def show
  	@post = Post.find(params[:id])
  end
 
  def create
  	@post = Post.new(post_params)
    @post.user_id = current_user.id
  	@post.save
  	redirect_to posts_path
  end

  def new
  	@post = Post.new
  end

  def edit
  	@post = Post.find(params[:id])  	
  end

  def update
  	@post = Post.find(params[:id])
  	# @post.update(post_params)
  	@post.title = params[:post][:title]
  	@post.content = params[:post][:content]
  	@post.save
  	redirect_to posts_path(@post.id)
  end

  def destroy
   	@post = Post.find(params[:id])  	
	@post.destroy 
	redirect_to posts_path	
  end


  private

  	def post_params
  		params.require(:post).permit(:title, :content)
  	end

end

