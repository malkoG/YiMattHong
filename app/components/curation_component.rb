# frozen_string_literal: true

class CurationComponent < ViewComponent::Base
  attr_reader :curation, :user, :board_ids

  def initialize(curation: nil, user: nil, board_ids: [])
    super
    @curation = curation
    @user = user
    @board_ids = board_ids
  end
end
