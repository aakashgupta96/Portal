class CreateJoinTablePostersPosts < ActiveRecord::Migration
  def change
    create_join_table :posters, :posts do |t|
       t.index [:poster_id, :post_id]
       t.index [:post_id, :poster_id]
    end
  end
end
