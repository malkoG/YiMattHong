# frozen_string_literal: true

require "fcm"

class Notifier
  def initialize
  end

  def do_something(fcm_token)
    fcm = FCM.new(ENV['FCM_SERVER_KEY'])
    options = {
      "notification": {
        "title": "Hello",
        "body": "World"
      }
    }

    response = fcm.send([fcm_token], options)
    puts response.to_json
  end
end
