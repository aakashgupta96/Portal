class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posted_projects, class_name: 'Project', foreign_key: "poster_id"
  has_many :current_projects, class_name: 'Project', foreign_key: "employee_id"
  has_and_belongs_to_many :bidded_projects, class_name: 'Project', :join_table => "bidders_projects",foreign_key: "bidder_id", association_foreign_key: "bidded_project_id"
  has_many :completed_projects, class_name: 'Project', foreign_key: "finisher_id" 

end
