class CurationsController < ApplicationController
  def index
    @curations = Curation.all.includes(:boards)
  end
end
