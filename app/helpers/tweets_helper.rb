module TweetsHelper
    def linkify_mentions(content)
        return unless content.present?

        content.gsub(/@(\w+)/) do |match|
            mention = $1
            user = User.find_by(name: mention)
            if user
                link_to match, user_path(user)
            else
                match
            end
        end.gsub(/(#\w+)/) do |match|
            hashtag = $1
            link_to match, tweets_by_hashtag_path(hashtag[1..])
        end.html_safe
    end
end
