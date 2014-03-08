require 'twitter_streaming'
require 'redis'

class SocketsController < ApplicationController
  include ActionController::Live

  def initialize
  end

  def stream
    
    response.headers['Content-Type'] = 'text/event-stream'

    sse = TwitterStreaming::SocketClient.new response.stream

    #Thread.new do 
      redis_sub = Redis.new
      redis_sub.subscribe("streams:trend:bieber") do |on|
        on.message do |channel, tweet_json|
          #puts "Received message from #{channel.to_s} :: #{tweet_json}"
          sse.write( tweet_json, event: 'tweet')
        end
      end
      #render nothing: true
    #end

    render nothing: true

    rescue IOError
      puts "IO ERROR"
    ensure
      response.stream.close unless !response.stream
      sse.close unless !sse
  end

end
