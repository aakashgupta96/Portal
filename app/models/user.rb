class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posted_projects, class_name: 'Project', foreign_key: "poster_id"
  has_many :taken_projects, class_name: 'Project', foreign_key: "employee_id"
  has_and_belongs_to_many :bidded_projects, class_name: 'Project', :join_table => "bidders_projects",foreign_key: "bidder_id", association_foreign_key: "bidded_project_id"
  has_many :completed_projects, class_name: 'Project', foreign_key: "finisher_id"

  validates_presence_of :username , :contact_no, :encrypted_password #checking presence of email is not required as it is being done by devise
  validates_uniqueness_of :email, :contact_no
  validates_length_of :contact_no, minimum: 10, maximum: 12
  validates_numericality_of :employee_ratings , greater_than_or_equal_to: 0 , less_than_or_equal_to: 5
  validates_numericality_of :employer_ratings , greater_than_or_equal_to: 0 , less_than_or_equal_to: 5

  attr_accessor :login

  after_initialize :init


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["contact_no = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:contact_no) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
   end

  def init
    self.employee_ratings  ||= 0.0
    self.employer_ratings ||= 0.0
  end

end
