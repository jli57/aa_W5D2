class SubsController < ApplicationController
  
  before_action only: [:update, :destroy] do 
    require_author(params[:sub][:moderator_id])
  end 

  def new
    @sub = Sub.new
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    require_author(@sub.moderator_id)
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def update
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub.destroy
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      redirect_to subs_url
    end
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
