class CuratedBoardComponent < ViewComponent::Base
  with_collection_parameter :board
  attr_reader :board, :user, :board_ids

  def initialize(board: nil, user: nil, board_ids: [])
    super
    @board = board
    @user = user
    @board_ids = board_ids
  end
end
