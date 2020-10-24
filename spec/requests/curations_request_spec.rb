require 'rails_helper'

RSpec.describe "Curations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get curations_path
      expect(response).to have_http_status(:success)
    end
  end
end
