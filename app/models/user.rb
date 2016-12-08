class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]

  attr_accessor :avatar, :remote_avatar_url
  mount_uploader :avatar, AvatarUploader

  has_many :posted_projects, class_name: 'Project', foreign_key: "poster_id"
  has_many :taken_projects, class_name: 'Project', foreign_key: "employee_id"
  has_and_belongs_to_many :bidded_projects, class_name: 'Project', :join_table => "bidders_projects",foreign_key: "bidder_id", association_foreign_key: "bidded_project_id"
  has_many :completed_projects, class_name: 'Project', foreign_key: "finisher_id"

  validates_presence_of :username, :first_name, :encrypted_password #checking presence of email is not required as it is being done by devise
  validates_uniqueness_of :email,:username
  validates :contact_no, uniqueness: true, allow_nil: true
  validates_length_of :contact_no, maximum: 12
  validates_numericality_of :employee_ratings , greater_than_or_equal_to: 0 , less_than_or_equal_to: 5
  validates_numericality_of :employer_ratings , greater_than_or_equal_to: 0 , less_than_or_equal_to: 5
  validate :avatar_size_validation

  attr_accessor :login

  after_initialize :init

  #acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags
  acts_as_ordered_taggable_on :tags
  scope :by_join_date, ->{
       order("created_at DESC")
  }
  acts_as_tagger

  #def to_param
   # username
  #end


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["contact_no = :value OR lower(email) = :value OR lower(username) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:contact_no) || conditions.has_key?(:email) || conditions.has_key?(:username)
        where(conditions.to_hash).first
      end
   end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      if(auth.info.email.nil?)
        return user
      end
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.username = auth.info.email.split("@").first
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split.first   # assuming the user model has a name
      user.last_name = auth.info.name.split.last   # assuming the user model has a name
      user.remote_avatar_url = auth.info.image.gsub('http://','https://') #"http://graph.facebook.com/#{auth.uid}/picture?type=large" # assuming the user model has an image
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["name"].split.first if user.first_name.blank?
        user.last_name = data["name"].split.last if user.last_name.blank?
        user.remote_avatar_url = "http://graph.facebook.com/#{data["id"]}/picture?type=large"
      end
    end
  end

  def init
    self.employee_ratings  = 0.0
    self.employer_ratings = 0.0
    self.contact_no = nil
  end

  def confirmation_required?
    !confirmed?
  end

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 5MB" if avatar.size > 5.megabytes
  end

end
