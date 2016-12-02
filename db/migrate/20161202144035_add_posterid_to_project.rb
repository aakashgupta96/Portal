class AddPosteridToProject < ActiveRecord::Migration
  def change
    add_column :projects, :poster_id, :integer
  end
end
