# frozen_string_literal: true

require 'discordrb/webhooks'

class DiscordNotifier
  class << self
    include ::Rails.application.routes.url_helpers

    def send_notification(notice)
      return unless check_notification_condition(notice)

      webhook_url = ''
      category = ''
      if notice.bbs_pk.in? [54]
        webhook_url = ENV['CE_NOTICE']
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

    private

    def check_notification_condition(notice)
      notice.bbs_pk.in?([54]) || true
    end
  end
end
