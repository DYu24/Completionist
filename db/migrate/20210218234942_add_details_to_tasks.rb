class AddDetailsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :description, :text
    add_column :tasks, :due_date, :date
    add_column :tasks, :due_time, :time
  end
end
