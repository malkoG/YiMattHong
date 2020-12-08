# frozen_string_literal: true

require 'discordrb/webhooks'

class DiscordNotifier
  class << self
    include ::Rails.application.routes.url_helpers

    def send_notification(notice)
      return unless check_notification_condition(notice)
      return unless notice.board.already_fetched?

      webhook_url = ''
      category = ''
      if notice.bbs_pk.in? computer_science_faculty
        webhook_url = ENV['CE_NOTICE']
        category = notice.board.category
      end

      if notice.bbs_pk.in? student_targeted_notices_bbs
        webhook_url = ENV['STUDENT_NOTICE']
        category = notice.board.category
      end

      client = Discordrb::Webhooks::Client.new(url: webhook_url)
      client.execute do |builder|
        builder.content = "[#{category}] 게시판에 새 글이 올라왔어요!"
        builder.add_embed do |embed|
          embed.title = notice.title
          embed.description = notice.content[0...100]
          embed.timestamp = notice.published_at.to_datetime

          embed.url = notice_url(notice)
        end
      end
    end

    def send_new_board_added(board)
      webhook_url = ENV['BOARD_ADDED_WEBHOOK']
      category = board.category

      client = Discordrb::Webhooks::Client.new(url: webhook_url)
      client.execute do |builder|
        builder.content = "[#{category}] 게시판의 소식을 읽을 수 있게 되었어요!"
        builder.add_embed do |embed|
          embed.title = board.category
          embed.description = board.description
          embed.timestamp = board.created_at

          embed.url = board_url(board)
        end
      end
    end

    private

    def check_notification_condition(board_or_notice)
      board_or_notice.bbs_pk.in?(computer_science_faculty) || board_or_notice.bbs_pk.in?(student_targeted_notices_bbs)
    end

    def computer_science_faculty
      [54, 89]
    end

    def student_targeted_notices_bbs
      [2, 3, 6, 8, 170]
    end
  end
end
