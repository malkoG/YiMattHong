class NoticeParser
  class << self
    def crawl_page(board_id, post_pk)
      url = generate_url(board_id, post_pk)

      cached_data = parse_html(html)
      attached_files = find_attachments(html)

      cached_data[:board_id] = board_id
      cached_data[:post_pk] = post_pk
      cached_data[:attachments] = attached_files
    end

    def parse_html(html)
      doc = Nokogiri::HTML(html)

      selectors = {
        title: '.bbs-read > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > th:nth-child(1)',
        author: 'div.unit:nth-child(1) > span:nth-child(2)',
        published_at: 'div.unit:nth-child(2) > span:nth-child(2)',
        content: '.substance',
      }

      options = {}

      selectors.each do |_attr, selector|
        options[_attr] = doc.css(selector)[0].content
      end

      return options
    end

    def find_attachments(html)
      attachment1 = ".inner > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(1) > span:nth-child(1) > span:nth-child(2)"
      attachment2 = ".inner > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(2) > td:nth-child(1) > span:nth-child(1) > span:nth-child(2)"
    end

    private
      def generate_url(board_id, post_pk)
        "http://www.hongik.ac.kr/front/boardview.do?pkid=#{post_pk}&currentPage=1&searchField=ALL&siteGubun=1&menuGubun=1&bbsConfigFK=#{board_id}&searchLowItem=ALL&searchValue="
      end
  end
end
