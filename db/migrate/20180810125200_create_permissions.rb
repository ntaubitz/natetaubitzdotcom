class CreatePermissions < ActiveRecord::Migration[5.0]
  def up
    create_table :permissions do |t|
      t.string :name, :limit => 32
      t.timestamps
    end
  end

  def down
    drop_table :permissions
  end
end
