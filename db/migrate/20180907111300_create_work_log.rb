class CreateWorkLog < ActiveRecord::Migration[5.0]
  def up
    create_table :work_logs do |t|
      t.belongs_to :user
      t.integer :user_id
      t.string :job, limit: 64
      t.column :started, :datetime
      t.column :ended, :datetime
      t.text :notes
      t.timestamps
    end
  end

  def down
    drop_table :blog_posts
  end
end
