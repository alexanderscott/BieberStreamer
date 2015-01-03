# This file is used by Rack-based servers to start the application.

require 'yaml'
require './lib/twitter_streaming'

require ::File.expand_path('../config/environment',  __FILE__)

env_file = File.join('./config', 'environment.yml')
YAML.load(File.open(env_file))['development'].each do |key, value|
  ENV[key.to_s] = value
end if File.exists?(env_file)

Thread.new do
  TwitterStreaming::StreamWorker.new({
    :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
    :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'],
    :access_token => ENV['TWITTER_ACCESS_TOKEN'],
    :access_token_secret => ENV['TWITTER_ACCESS_TOKEN_SECRET']
  })
end

run Rails.application
