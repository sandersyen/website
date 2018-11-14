class PagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def terms
  end

  def explore
    @events = Event.all
  end
end
