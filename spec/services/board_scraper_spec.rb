# frozen_string_literal: true

require "rails_helper"

RSpec.describe BoardScraper, type: :service do
  describe "#parse_html" do
    context "게시판 리스트를 긁어올 때" do
      it "최상단 공지글을 제외하고 긁어온다." do
        html = File.read Rails.root.join('spec', 'fixtures', 'hongik_ce_board.html')

        board = create(:board)

        scraper = BoardScraper.new(board)
        post_pks = scraper.parse_html(html)

        expect(post_pks.size).to eq(15)
      end
    end

    context "이미 긁어온 자료가 있다면," do
      it "긁어온 자료를 제외하고 긁어온다." do
        board = create(:board, bbs_pk: 53)
        create(:notice, post_pk: 141543, board: board, bbs_pk: board.bbs_pk)
        create(:notice, post_pk: 141666, board: board, bbs_pk: board.bbs_pk)

        html = File.read Rails.root.join('spec', 'fixtures', 'hongik_ce_board.html')

        scraper = BoardScraper.new(board)
        post_pks = scraper.parse_html(html)

        expect(post_pks.size).to eq(13)
      end
    end
  end
end
