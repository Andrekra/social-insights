require_relative 'authentication'
require_relative 'user'
require_relative 'channel'

module SocialInsight
  module Facebook
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= SocialInsight::Facebook::Configuration.new
      yield(self.configuration)
    end

    class Configuration
      attr_accessor :app_id
      attr_accessor :app_secret
      attr_accessor :scope

      def initialize
        @app_id = ENV['FACEBOOK_APP_ID']
        @app_secret = ENV['FACEBOOK_APP_SECRET']
        @scope = 'manage_pages,read_insight'
      end
    end
  end
end
