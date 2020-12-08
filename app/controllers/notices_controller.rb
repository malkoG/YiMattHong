class NoticesController < ApplicationController
  def index
    @notices = Notice.all.order('published_at desc').page(params[:page])
  end

  def show
    @notice = Notice.find(params[:id])
  end
end
