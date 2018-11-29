class PagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def terms
  end

  def explore ()
    @events = Event.all
   # @groups = Group.all
   @groups = Group.where( is_viewable: true )
    if (params[:search_event])
      @events = Event.where("name LIKE :search_event OR description LIKE :search_event OR location LIKE :search_event", search_event: "%#{params[:search_event]}%")
    end

    if (params[:search_group])
      @groups = Group.where("name LIKE :search_group OR description LIKE :search_group", search_group: "%#{params[:search_group]}%")
    end
  end
end
