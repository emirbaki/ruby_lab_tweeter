class CreateMentionsTweetsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :mentions_tweets, id: false do |t|
      t.references :user, foreign_key: true
      t.references :tweet, foreign_key: true
    end
  end
end
