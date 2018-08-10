class CreateUserGroups < ActiveRecord::Migration[5.0]
  def up
    create_table :user_groups do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end
  end

  def down
    drop_table :user_groups
  end
end
