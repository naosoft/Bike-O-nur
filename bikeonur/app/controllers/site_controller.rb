class SiteController < ApplicationController
  def index
    @title = "Witaj"
  end
  
  def about
    @title = "o nas"
  end
  
  def help
    @title = "Pomoc"
  end
  
  
end
