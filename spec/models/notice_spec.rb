require 'rails_helper'

RSpec.describe Notice, type: :model do
  describe "About Association" do
    context "with 'Board' Model" do
      it "should belong to Board" do
        board = described_class.reflect_on_association(:board)
        expect(board.macro).to eq(:belongs_to)
      end
    end
  end
end
