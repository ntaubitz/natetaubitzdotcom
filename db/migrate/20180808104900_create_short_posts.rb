class CreateShortPosts < ActiveRecord::Migration[5.0]
  def up
    create_table :short_posts do |t|
      t.belongs_to :user
      t.integer :user_id
      t.string :text, :limit => 512
      t.timestamps
    end
  end

  def down
    drop_table :short_posts
  end
end
