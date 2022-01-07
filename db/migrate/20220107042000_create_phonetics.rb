class CreatePhonetics < ActiveRecord::Migration[5.0]
  def up
    create_table :phonetics do |t|
      t.belongs_to :word
      t.string :letters, :limit => 64
      t.timestamps
    end
  end

  def down
    drop_table :phonetics
  end
end
