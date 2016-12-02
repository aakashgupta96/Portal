class AddFinisherToProject < ActiveRecord::Migration
  def change
    add_column :projects, :finisher_id, :integer
  end
end
