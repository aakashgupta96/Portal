class Project < ActiveRecord::Base
	belongs_to :poster, class_name: 'User'
	belongs_to :employee, class_name: 'User'
	belongs_to :finisher, class_name: 'User'
	has_and_belongs_to_many :bidders, class_name: 'User', join_table: "bidders_projects",foreign_key: "bidded_project_id", association_foreign_key: "bidder_id"
	has_and_belongs_to_many :categories, class_name: 'Category', join_table: "categories_projects", foreign_key: "project_id", association_foreign_key: "category_id"
	validates_presence_of :budget , :description , :title , :time , :poster_id
	validates_length_of :description, minimum: 0, maximum: 400


	acts_as_taggable_on :skills
	acts_as_ordered_taggable_on :skills
	scope :by_join_date, ->{
	    order("created_at DESC")
  	}

end
