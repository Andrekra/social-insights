module SocialInsight
  module Facebook
    # A Channel is a 'portal' in which the influencer can reach it's users.
    # This could be a website, a facebook page, a twitter account or a youtube channel.
    class Channel < SocialInsight::Channel
      # How many users can a influencer reach?
      # On facebook these are page likes, twitter; followers, blog; daily visits, youtube; subscribers
      def reach
      end

      # posts/tweets/videos/pictures used to reach the audience
      def activities
      end

      # The lastest datetime the user posts something in this channel
      def latest_activity_date
      end

      # Demographics
      def countries(since=DateTime.now-1.day)
      end

      def age_groups(since=DateTime.now-1.day)
      end

      def gender(since=DateTime.now-1.day)
      end

      # Fetch new insights
      def sync

      end
    end
  end
end
