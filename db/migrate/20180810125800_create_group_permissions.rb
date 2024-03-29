class CreateGroupPermissions < ActiveRecord::Migration[5.0]
  def up
    create_table :group_permissions do |t|
      t.belongs_to :group
      t.belongs_to :permission
      t.timestamps
    end
  end

  def down
    drop_table :group_permissions
  end
end
