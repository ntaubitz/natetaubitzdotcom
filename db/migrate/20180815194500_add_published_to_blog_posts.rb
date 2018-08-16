class AddPublishedToBlogPosts < ActiveRecord::Migration[5.0]
  def up
    add_column :blog_posts, :published, :boolean, default: false
  end

  def down
    remove_column :blog_posts, :published
  end
end
