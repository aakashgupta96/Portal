class ChangeContactNo < ActiveRecord::Migration
  def change
  	change_column :users, :contact_no, :string, null: true
  end
end
