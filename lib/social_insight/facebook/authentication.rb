require 'koala'
module SocialInsight
  module Facebook
    module Authentication
      protected
      def api(access_token)
        Koala::Facebook::API.new access_token
      end
    end
  end
end
