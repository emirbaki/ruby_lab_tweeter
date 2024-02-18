class CreateHashtags < ActiveRecord::Migration[7.1]
  def change
    create_table :hashtags do |t|
      t.string :name

      t.timestamps
    end
  end
end
