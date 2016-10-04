require "social_insight/version"
require "social_insight/errors/authorization_error"
require "social_insight/errors/configuration_error"
require "social_insight/facebook/facebook"

module SocialInsight
  # Your code goes here...
end

# Test code
require 'dotenv'
Dotenv.load
SocialInsight::Facebook.configure do |config|
  config.app_id = ENV['FACEBOOK_APP_ID']
  config.app_secret = ENV['FACEBOOK_APP_SECRET']
end
