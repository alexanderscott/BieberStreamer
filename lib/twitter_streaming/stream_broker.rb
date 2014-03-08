require 'thread'
require 'erb'
require 'redis'
require 'json'

module TwitterStreaming
  class StreamBroker  
    def initialize( redis_config = {} )
      redis_config ||= { host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'] }

      @threads = []

      begin
        @redis = Redis.new( redis_config )
        @redis_pub = Redis.new( redis_config )
      rescue
        raise "Error connecting to Redis"
      end
    end

    def new
      @redis
    end

    def close
      @redis.quit
      @redis_pub.quit
      @threads.each { |thread| thread.close } 
    end

    def subscribe_to_stream_updates emit
      @redis.psubscribe("streams:new:") do |on|
        on.message do |channel, msg|
          stream_type = channel.split(':')[2]
          stream_val = channel.split(':')[3]
          emit(stream_type, stream_val, sanitize(msg))
        end
      end
    end

    def publish_to_trend_stream trend_str, msg
      @redis.publish("streams:trend:#{trend_str}", JSON.generate(msg))
    end

    private 
      def _new_thread thread_fxn
        puts "Opening a new thread for an overall total of #{ Thread.count + 1 }"
        thread = Thread.new thread_fxn
        @threads << thread 
      end

      def sanitize(message)
        json = JSON.parse(message)
        json.each {|key, value| json[key] = ERB::Util.html_escape(value) }
        JSON.generate(json)
      end

  end
end
