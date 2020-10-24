require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "About Association" do
    context "with 'Notice' Model" do
      it "should has many Notice" do
        notices = described_class.reflect_on_association(:notices)
        expect(notices.macro).to eq(:has_many)
      end
    end
  end
end
