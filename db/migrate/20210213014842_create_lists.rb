class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.belongs_to :user, null: false

      t.timestamps
    end

    add_reference :tasks, :list, foreign_key: true
  end
end
