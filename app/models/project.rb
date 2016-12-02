class Project < ActiveRecord::Base
	belongs_to :poster, class_name: 'User'
	belongs_to :employee, class_name: 'User'
	belongs_to :finisher, class_name: 'User'
	has_and_belongs_to_many :bidders, class_name: 'User', :join_table => "bidders_projects",foreign_key: "bidded_project_id", association_foreign_key: "bidder_id"
end
