class NoticesController < ApplicationController
  def index
    @notices = Notice.all.order('published_at desc')
  end

  def show
    @notice = Notice.find(params[:id])
  end
end
