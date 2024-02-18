# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_17_191013) do
  create_table "hashtags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtags_tweets", id: false, force: :cascade do |t|
    t.integer "hashtag_id"
    t.integer "tweet_id"
    t.index ["hashtag_id"], name: "index_hashtags_tweets_on_hashtag_id"
    t.index ["tweet_id"], name: "index_hashtags_tweets_on_tweet_id"
  end

  create_table "mentions_tweets", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "tweet_id"
    t.index ["tweet_id"], name: "index_mentions_tweets_on_tweet_id"
    t.index ["user_id"], name: "index_mentions_tweets_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.string "text"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "hashtags_tweets", "hashtags"
  add_foreign_key "hashtags_tweets", "tweets"
  add_foreign_key "mentions_tweets", "tweets"
  add_foreign_key "mentions_tweets", "users"
  add_foreign_key "tweets", "users"
end
