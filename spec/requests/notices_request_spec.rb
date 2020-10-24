require 'rails_helper'

RSpec.describe "Notices", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get notices_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      notice = create(:notice, board: create(:board, bbs_pk: 123))
      get notice_path(notice)
      expect(response).to have_http_status(:success)
    end
  end

end
