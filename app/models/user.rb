class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posted_projects, class_name: 'Project', foreign_key: "poster_id"
  has_many :current_projects, class_name: 'Project', foreign_key: "employee_id"
  has_and_belongs_to_many :bidded_projects, class_name: 'Project', :join_table => "bidders_projects",foreign_key: "bidder_id", association_foreign_key: "bidded_project_id"
  has_many :completed_projects, class_name: 'Project', foreign_key: "finisher_id" 

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["contact_no = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:contact_no) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
   end

end
