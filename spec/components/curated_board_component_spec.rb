require "rails_helper"

RSpec.describe CuratedBoardComponent, type: :component do
  let(:board1) { create(:board, category: '강한친구', description: '대한육군') }
  let(:board2) { create(:board, category: '친구는 오랜친구 죽마고우', description: '국민연료 썬연료') }

  describe "#initialize" do
    it "board 모델에 대한 정보를 적절히 보여준다." do
      render_inline(described_class.new(board: board1))
      expect(page).to have_css('.board-category', text: '강한친구')
      expect(page).to have_css('.board-description', text: '대한육군')

      render_inline(described_class.new(board: board2))
      expect(page).to have_css('.board-category', text: '친구는 오랜친구 죽마고우')
      expect(page).to have_css('.board-description', text: '국민연료 썬연료')
    end
  end

  describe "#with_collection" do
    it "board들을 card의 형태로 보여준다." do
      render_inline(described_class.with_collection([board1, board2]))
      expect(page).to have_css('.curation-card', count: 2)
    end
  end
end
