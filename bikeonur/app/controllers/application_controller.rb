# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
 # helper :all # include all helpers, all the time
#  protect_from_forgery # See ActionController::RequestForgeryProtection for details
include ApplicationHelper

  before_filter :check_authorization

  def check_authorization
    authorization_token = cookies[:authorization_token]
    if authorization_token and not logged_in?
      user = User.find_by_authorization_token(authorization_token)
      user.login!(session) if user
    end
  end

  def param_posted?(sym)
    request.post? and params[sym]
  end


  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "zaloguj sie"
      redirect_to :controller => "user", :action => "login"
      return false
    end
  end

end
