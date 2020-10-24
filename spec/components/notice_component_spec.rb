require "rails_helper"

RSpec.describe NoticeComponent, type: :component do
  let(:board) { create(:board, bbs_pk: 52) }
  let(:notice) { create(:notice, board: board) }

  context "첨부 파일이 없을 때" do
    it "첨부 파일이 없는 공지사항을 렌더링한다." do
      notice.update(
        title: '입영통지서 안내',
        author: '굳건이',
        published_at: '2019-00-19',
        content: '<div>강한친구 대한육군</div>'
      )
      rendered_result = render_inline(described_class.new(notice: notice))

      expect(rendered_result.css('.notice-title').to_html).to include('입영통지서 안내')
      expect(rendered_result.css('.notice-author').to_html).to include('굳건이')
      expect(rendered_result.css('.notice-published-at').to_html).to include('2019-00-19')
      expect(rendered_result.css('.notice-content').to_html.strip).to include('<div>강한친구 대한육군</div>')
    end
  end
end
