require 'twitter_streaming'

# Use a new thread to run our twitter stream worker
# Worker listens on requested streams and publishes via Redis
Thread.new do
  TwitterStreaming::StreamWorker.new({
    :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
    :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'],
    :access_token => ENV['TWITTER_ACCESS_TOKEN'],
    :access_token_secret => ENV['TWITTER_ACCESS_TOKEN_SECRET']
  })
end
