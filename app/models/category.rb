class Category < ActiveRecord::Base

  has_and_belongs_to_many :projects, class_name: 'Project', join_table: "categories_projects", foreign_key: "category_id", association_foreign_key: "project_id"
end
