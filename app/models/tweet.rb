class Tweet < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :hashtags
  has_and_belongs_to_many :mentions, class_name: 'User', join_table: 'mentions_tweets'

  validates :content, presence: true

  after_save :extract_hashtags_and_mentions
  def extract_hashtags_and_mentions
    self.hashtags = content.scan(/#\w+/).map { |name| Hashtag.find_or_create_by(name: name.downcase) }
    self.mentions = content.scan(/@(\w+)/).map { |name| User.find_by(name: name) }.compact
  end

end
