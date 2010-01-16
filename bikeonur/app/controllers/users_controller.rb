class UsersController < ApplicationController

include ApplicationHelper
  before_filter :protect, :only => [:index, :edit]


  def index
    @title = ""
  end

  def register
    @title = "Rejestracje"
     if param_posted?(:user)
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session)
        flash[:notice] = "Witaj twój użtkownik #{@user.login} jest utowrzony"
       #  redirect_to :action => "index", :controller => "site"
        redirect_to_forwarding_url
      else
        @user.clear_password!
      end
    end
 #   @user.clear_password!
  end

  def login
    @title = "Logowanie"
     if request.get?
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_login_and_password(@user.login,
                                                   @user.password)
      if user
        user.login!(session)
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies)
        flash[:notice] = "witaj #{@user.login}!"
        # redirect_to :action => "index", :controller => "site"
         redirect_to_forwarding_url
      else
        @user.clear_password!
        flash[:notice] = "Niepoprawny login/haslo "
      end
    end
  end

  def logout
    @title = "Pa pa"
     User.logout!(session, cookies)
    flash[:notice] = "Wylogowany"
    redirect_to :action => "index", :controller => "site"
  end

private


def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end


  def remember_me_string
    cookies[:remember_me] || "0"
  end

  
  def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      flash[:notice] = " #{attribute} zaktualizowany."
      redirect_to :action => "index"
    end
  end


end
