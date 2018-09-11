class AddBilledToWorkLogs < ActiveRecord::Migration[5.0]
  def up
    add_column :work_logs, :billed, :boolean, default: false
  end

  def down
    remove_column :work_logs, :billed
  end
end
