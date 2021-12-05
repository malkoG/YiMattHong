require 'rails_helper'

RSpec.describe "Boards", type: :request do
  describe "GET /show" do
    context "올바른 게시판에 접근할 때" do
      it "returns http success" do
        board = create(:board, bbs_pk: 123)
        get board_path(board)
        expect(response).to have_http_status(:success)
      end
    end

    context "검색 기능을 이용할 때" do
      let(:sample_board) { create(:board, bbs_pk: 123) }

      context "검색 키워드가 주어질 경우" do
        it "Alert 창이 표시된다." do
          get board_path(sample_board, q: "Hello World")
          expect(response.body).to have_css(".search-result")
        end
      end

      context "검색 키워드가 주어지지 않을 경우" do
        it "Alert 창이 표시되지 않는다." do
          get board_path(sample_board)
          expect(response.body).not_to have_css(".search-result")
        end
      end
    end
  end
end
