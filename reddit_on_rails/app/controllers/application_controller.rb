class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in? 
  
  def login!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end 
  
  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil 
    @current_user = nil 
  end
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logged_in? 
    !!current_user
  end
  
  def require_moderator(sub_id)
    unless current_user.id == Sub.find_by(id: sub_id).moderator_id
      flash[:errors] = ["Unauthorized action"]
      redirect_to subs_url 
    end
  end
  
  def require_author(post_id)
    unless current_user.id == Post.find_by(id: post_id).author_id
      flash[:errors] = ["Unauthorized action"]
      redirect_to subs_url 
    end
  end
  
end
