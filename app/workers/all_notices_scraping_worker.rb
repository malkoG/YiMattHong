# frozen_string_literal: true

class AllNoticesScrapingWorker
  include Sidekiq::Worker

  def perform(*args)
    Board.all.each do |board|
      scraper = BoardScraper.new(board)
      scraper.scrap_board_list
    end
  end
end
