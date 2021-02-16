class RemoveUserRefFromTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :user_id, :bigint
  end
end
