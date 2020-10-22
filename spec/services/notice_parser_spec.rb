# frozen_string_literal: true

require "rails_helper"

RSpec.describe NoticeParser, type: :service do
  describe "#parse_html" do
    it "긁어올 수 있는건 잘 긁어진다." do
      html = File.read Rails.root.join('spec', 'fixtures', 'hongik_ce_board_detail_with_download.html')
      options = NoticeParser.parse_html(html)
      expect(options[:title]).to eq("강한친구 대한육군 강한친구 대한육군")
      expect(options[:author]).to eq("리재열")
      expect(options[:published_at]).to eq("2020.09.14  11:23:59")
      expect(options[:content].strip).to eq('강한친구 대한육군')
    end
  end

  describe "#find_attachments" do
    context "첨부 파일이 없는 경우" do
      it "비어있는 배열을 반환." do
        html = File.read Rails.root.join('spec', 'fixtures', 'hongik_ce_board_detail_without_download.html')
        attachments = NoticeParser.find_attachments(html)

        expect(attachments.size).not_to eq(1)
      end
    end

    context "첨부 파일이 있는 경우" do
      it "1개 이상의 attachment가 포함된 JSON Array를 반환" do
        html = File.read Rails.root.join('spec', 'fixtures', 'hongik_ce_board_detail_with_download.html')
        attachments = NoticeParser.find_attachments(html)

        expect(attachments.size).not_to eq(0)
      end
    end
  end
end
