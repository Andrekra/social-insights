require "social_insight/errors/configuration_error"
require "social_insight/errors/authorization_error"

require_relative 'authentication'
module SocialInsight
  module Facebook
    class User
      include Authentication

      def initialize token
        # Todo Find a better way
        raise SocialInsight::Errors::ConfigurationError, "Facebook app id not configured" if SocialInsight::Facebook.configuration.app_id.nil?
        raise SocialInsight::Errors::ConfigurationError, "Facebook app secret not configured" if SocialInsight::Facebook.configuration.app_secret.nil?
        @token = token
        @graph = api(token)
      end

      def renew_token
        # Exhange short living token (2h) to a long living (60 days)
        #https://developers.facebook.com/docs/facebook-login/access-tokens?locale=nl_NL#extending
        oath = Koala::Facebook::OAuth.new SocialInsight::Facebook.configuration.app_id, SocialInsight::Facebook.configuration.app_secret
        response = oath.exchange_access_token_info(@token)

        # Todo Dont renew everytime, only when expired
        @expires_at = Time.at(Time.now.to_i + response["expires"].to_i).to_datetime
        @token = response["access_token"]
      end

      def accounts
        begin
          accounts = []
          loop do
            fb_accounts = @graph.get_connections('me', 'accounts?fields=likes,access_token,name,perms,posts.limit(1).fields(created_time)')
            fb_accounts.keep_if { |account| account['perms'].include? 'CREATE_CONTENT' }
            accounts << fb_accounts.map do |account|
              latest_post_date = account.has_key?('posts') ? DateTime.parse(account['posts']['data'].first['created_time']) : nil
              {
                social_uid: account['id'],
                title: account['name'],
                reach: account['likes'],
                last_post_date: latest_post_date,
                access_token: account['access_token']
              }
            end
            fb_accounts = fb_accounts.next_page
            break if fb_accounts.nil?
          end
          accounts.flatten
        rescue Koala::Facebook::AuthenticationError => message
          raise SocialInsight::Errors::AuthorizationError, message
        end
      end
    end
  end
end
