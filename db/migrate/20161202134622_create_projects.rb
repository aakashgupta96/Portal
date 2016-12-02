class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :budget
      t.string :description
      t.string :avgbig
      t.string :time

      t.timestamps null: false
    end
  end
end
