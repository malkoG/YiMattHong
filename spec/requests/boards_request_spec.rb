require 'rails_helper'

RSpec.describe "Boards", type: :request do
  describe "GET /show" do
    it "returns http success" do
      board = create(:board, bbs_pk: 123)
      get board_path(board)
      expect(response).to have_http_status(:success)
    end
  end
end
