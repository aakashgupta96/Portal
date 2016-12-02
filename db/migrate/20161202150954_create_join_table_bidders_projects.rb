class CreateJoinTableBiddersProjects < ActiveRecord::Migration
  def change
    create_join_table :bidders, :projects do |t|
       t.index [:bidder_id, :project_id]
       t.index [:project_id, :bidder_id]
    end
  end
end
