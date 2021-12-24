require 'rails_helper'

RSpec.describe NoticeFinder, type: :finder do
  describe "#execute" do
    let(:curation) { create(:curation) }
    let(:board) { create(:board, curation: curation) }
    let(:notice1) { create(:notice, board: board, title: "자율학습동아리 신청 모집") }
    let(:notice2) { create(:notice, board: board, title: "어쩌구저쩌구소프트 인턴 모집") }
    let(:notice3) { create(:notice, board: board, title: "자율주행자동차 전문가 과정 모집") }
    let(:notice4) { create(:notice, board: board, title: "2022학년도 1학기 학/석사 연계과정 모집") }
    let(:notice5) { create(:notice, board: board, title: "취업(진로) 집중 컨설팅 참여 신청 공지") }
    let(:notice6) { create(:notice, board: board, title: "복수전공 이수요건 관련 안내") }

    before(:each) do
      [notice1, notice2, notice3, notice4, notice5, notice6].each do |notice|
        notice.update(romanized_title: Gimchi.romanize(notice.title))
      end
    end

    context "올바른 검색 키워드를 넘겨줄 경우" do
      it "'모집' 키워드로 검색했을때 4개의 레코드가 검색된다." do
        params = {
          id: board.id,
          q: '모집'
        }

        notices = NoticeFinder.new(params).execute
        expect(notices.count).to eq(4)
      end

      it "'자율' 키워드로 검색했을때 2개의 레코드가 검색된다." do
        params = {
          id: board.id,
          q: '자율'
        }

        notices = NoticeFinder.new(params).execute
        expect(notices.count).to eq(2)
      end
    end

    context "유효하지 않은 검색 키워드를 넘겨줄 경우" do
      it "어떤 공지사항도 검색되지 않는다." do
        params = {
          id: board.id,
          q: '2022년도 전기 컴퓨터공학과 대학원 설명회'
        }

        notices = NoticeFinder.new(params).execute
        expect(notices.count).to eq(0)
      end
    end
  end
end