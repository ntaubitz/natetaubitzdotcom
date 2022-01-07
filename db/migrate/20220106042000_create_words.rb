class CreateWords < ActiveRecord::Migration[5.0]
  def up
    create_table :words do |t|
      t.string :letters, :limit => 64
      t.timestamps
    end
  end

  def down
    drop_table :words
  end
end
