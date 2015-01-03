require 'twitter'
require 'twitter_streaming/stream_broker'

module TwitterStreaming
  module StreamWorker

    class << self

      def initialize (config = {})
        puts "StreamWorker initialized"
      end

      def new(env)
        puts "StreamWorker new called with trend: #{$trend}"
        begin 
          @broker = StreamBroker.new

          @tw_stream_client = Twitter::Streaming::Client.new do |twitter| 
            twitter.consumer_key = ENV['TWITTER_CONSUMER_KEY']
            twitter.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
            twitter.access_token = ENV['TWITTER_ACCESS_TOKEN']
            twitter.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
          end

        rescue
          raise "Error connecting to twitter stream"
        end

        @tw_stream_client.filter(:track => $trend) do |tw_object|

          # Check if stream return is a tweet (could be direct message, follow request, etc)
          if tw_object.is_a?(Twitter::Tweet)

            # Grab only the params we need to publish
            tweet = {
              :text => tw_object.text,
              :user_tw_id => tw_object.user.id,
              :user_nickname => tw_object.user.screen_name,
              :user_image => tw_object.user.profile_image_url,
              :created_at => tw_object.created_at,
              :replied_to => tw_object.in_reply_to_user_id
            }
            
            #puts "Received tweet #{tw_object.text}"
            @broker.publish_to_trend_stream( $trend, tweet )
          end
        end
      end


      def close
        @broker.close

        # FIXME - safely close the tw stream connection?
        #@tw_stream_client = nil
      end

    end
  end
end
