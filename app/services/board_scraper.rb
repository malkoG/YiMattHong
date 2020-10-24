# NOTE : See https://stackoverflow.com/questions/60065152/rails-rake-task-fails-just-in-production-nomethoderror-private-method-open
require 'open-uri'

class BoardScraper
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def scrap_board_list
    bbs_pk = board.bbs_pk

    url = generate_url(bbs_pk)
    html = URI.open(url)

    post_pks = parse_html(html)
    post_pks.each do |post_pk|
      next unless post_pk.present?
      NoticeParser.crawl_page(board.id, bbs_pk, post_pk)
    end
  end

  def parse_html(html)
    doc = Nokogiri::HTML(html)
    post_pks = []

    selector = '.grid > table:nth-child(1) > tbody:nth-child(3) > tr'
    doc.css(selector).each do |row|
      next if row.inner_html.include? 'icon typ top'

      post_pk = parse_list_row(row)
      post_pks << post_pk unless Notice.exists?(bbs_pk: board.bbs_pk, post_pk: post_pk)
    end

    post_pks
  end

  private
    def generate_url(bbs_pk)
      "http://www.hongik.ac.kr/front/boardlist.do?bbsConfigFK=#{bbs_pk}&siteGubun=1&menuGubun=1"
    end

    def parse_list_row(doc)
      begin
        post_pk = doc.inner_html.match(/pkid=(\d+)/)[1].to_i
      rescue => ex
        post_pk = nil
      end

      return post_pk
    end
end
