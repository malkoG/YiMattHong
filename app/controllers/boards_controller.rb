class BoardsController < ApplicationController
  def show
    @notices = Board
      .includes(:notices)
      .find(params[:id])
      .notices
  end
end
