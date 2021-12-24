# NOTE : See https://stackoverflow.com/questions/60065152/rails-rake-task-fails-just-in-production-nomethoderror-private-method-open
require 'open-uri'

class NoticeParser
  class << self
    def crawl_page(board_id, bbs_pk, post_pk)
      url = generate_url(bbs_pk, post_pk)
      html = URI.open(url)

      cached_data = parse_html(html)
      attachments = find_attachments(html)

      cached_data[:bbs_pk] = bbs_pk.to_i
      cached_data[:board_id] = board_id.to_i
      cached_data[:post_pk] = post_pk.to_i
      cached_data[:attachments] = attachments

      notice = Notice.create(**cached_data)
      notice.update(romanized_title: Gimchi.romanize(notice.title))
      DiscordNotifier.send_notification(notice)
    end

    def parse_html(html)
      doc = Nokogiri::HTML(html)

      selectors = {
        title: '.bbs-read > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > th:nth-child(1)',
        author: 'div.unit:nth-child(1) > span:nth-child(2)',
        published_at: 'div.unit:nth-child(2) > span:nth-child(2)',
      }

      options = {}

      selectors.each do |_attr, selector|
        options[_attr] = doc.css(selector)[0].content
      end

      options[:content] = doc.css('.substance')[0].inner_html
      return options
    end

    def find_attachments(html)
      doc = Nokogiri::HTML(html)
      attachments = []

      row_selector = '.inner > table:nth-child(1) > tbody:nth-child(2) > tr'
      doc.css(row_selector).each do |row|
        title = row.css('td:nth-child(1) > span:nth-child(1) > span:nth-child(2)')[0].content
        attachment_url = row.css('td:nth-child(2) > a')[0]['href']

        attachments << {
          title: title,
          url: wrap_attachment(attachment_url)
        }
      end

      return attachments
    end

    private
      def generate_url(bbs_pk, post_pk)
        "http://www.hongik.ac.kr/front/boardview.do?pkid=#{post_pk}&currentPage=1&searchField=ALL&siteGubun=1&menuGubun=1&bbsConfigFK=#{bbs_pk}&searchLowItem=ALL&searchValue="
      end

      def wrap_attachment(suffix_url)
        "http://www.hongik.ac.kr#{suffix_url}"
      end
  end
end
