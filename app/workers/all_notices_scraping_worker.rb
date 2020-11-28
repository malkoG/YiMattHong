# frozen_string_literal: true

class AllNoticesScrapingWorker
  include Sidekiq::Worker

  def perform(*args)
    Board.all.each do |board|
      scraper = BoardScraper.new(board)
      scraper.scrap_board_list

      unless board.already_fetched?
        DiscordNotifier.send_new_board_added(board)
        board.update(already_fetched: true)
      end
    end
  end
end
