# frozen_string_literal: true

class BoardsController < ApplicationController
  def show
    @notices = Board
      .includes(:notices)
      .find(params[:id])
      .notices
      .order('published_at desc')
  end
end
