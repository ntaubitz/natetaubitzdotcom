class CreateBlogPosts < ActiveRecord::Migration[5.0]
  def up
    create_table :blog_posts do |t|
      t.belongs_to :user
      t.string :subject, :limit => 128
      t.text :markup
      t.timestamps
    end
  end

  def down
    drop_table :blog_posts
  end
end
