class AddCategoryToBlogPosts < ActiveRecord::Migration[5.0]
  def up
    add_column :blog_posts, :category, "ENUM('software_development', 'family', 'health', 'jeeps') DEFAULT 'software_development'"
  end

  def down
    remove_column :blog_posts, :category
  end
end
