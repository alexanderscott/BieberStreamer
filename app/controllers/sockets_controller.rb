require 'json'
class SocketsController < ApplicationController
  include ActionController::Live
  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    redis_sub = Redis.new
    redis_sub.subscribe("streams:trend:bieber") do |on|
      on.message do |channel, tweet_json|
        ##puts "Received message from #{channel.to_s} :: #{tweet_json}"
        response.stream.write(sse(tweet_json, {event: 'tweet'}))
      end
    end
  rescue IOError
  # Client Disconnected
  ensure
    response.stream.close
  end

  private

  def sse(object, options = {})
    (options.map{|k,v| "#{k}: #{v}" } << "data: #{object}").join("\n") + "\n\n"
  end
end
