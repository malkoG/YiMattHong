class CurationsController < ApplicationController
  def index
    @curations = Curation.all.includes(:boards)
    @board_ids = current_user&.subscriptions&.pluck(:board_id)
  end
end
