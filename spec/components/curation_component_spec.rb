require "rails_helper"

RSpec.describe CurationComponent, type: :component do
  let(:curation1) { create(:curation, title: '강한친구', description: '대한육군') }
  let(:curation2) { create(:curation, title: '친구는 오랜친구 죽마고우', description: '국민연료 썬연료') }

  describe "#initialize" do
    it "Curation 모델에 대한 정보를 적절히 보여준다." do
      render_inline(described_class.new(curation: curation1))
      expect(page).to have_css('.curation-title', text: '강한친구')
      expect(page).to have_css('.curation-description', text: '대한육군')

      render_inline(described_class.new(curation: curation2))
      expect(page).to have_css('.curation-title', text: '친구는 오랜친구 죽마고우')
      expect(page).to have_css('.curation-description', text: '국민연료 썬연료')
    end
  end

  describe "#with_collection" do
    it "큐레이션에 연결된 공지사항 목록을 보여준다." do
      3.times do
        create(:board, curation: curation1)
        create(:board, curation: curation2)
      end

      render_inline(described_class.with_collection([curation1, curation2]))
      expect(page).to have_css('.curation', count: 2)
      expect(page).to have_css('.curation-card', count: 6)
    end
  end
end
