class AddSecurityToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :salt, :string, :limit => 255
    add_column :users, :crypted_password, :string, :limit => 255
  end

  def down
    remove_column :users, :salt
    remove_column :users, :crypted_password
  end
end
