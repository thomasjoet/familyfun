class StaticPagesController < ApplicationController
  def home
    @reading = current_user.readings.build if logged_in?
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end
