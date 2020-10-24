class NoticesController < ApplicationController
  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find(params[:id])
  end
end
