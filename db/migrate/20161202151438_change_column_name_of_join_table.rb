class ChangeColumnNameOfJoinTable < ActiveRecord::Migration
  def change
  	rename_column :bidders_projects, :project_id, :bidded_project_id
  end
end
