class PostsController < ApplicationController
  
  before_action only: [:update, :destroy] do 
    require_author(params[:post][:author_id])
  end 

  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    @subs = Sub.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @subs = Sub.all
    @post = Post.find_by(id: params[:id])
    require_author(@post.author_id)
  end

  def create
    @subs = Sub.all 
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @subs = Sub.all
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    if @post.destroy
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to posts_url
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
  
end
