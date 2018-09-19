class CommentsController < ApplicationController
  # before_action only: [:update, :destroy] do 
  #   require_author(params[:author_id])
  # end 
  
  def edit
    @comment = Comment.find_by(id: params[:id])
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.parent_comment_id = params[:comment][:parent_comment_id]
    
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post)
    end
  end
  
  def update
    @comment = current_user.comments.find_by(id: params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post)
    end
  end
  
  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
    if @comment.destroy
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to comments_url
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
