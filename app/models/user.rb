# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  password_digest        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord

  before_save :proper_case
    ########  Members/followers and following 
  
  #current user for following other users
  #dependent: :destroy, prevents orphan records by destroying any associated records if the user is destroyed

  has_many :members, foreign_key: :follower_id, dependent: :destroy 
  has_many :subscribers, through: :members

  #other users following the current user

  has_many :reverse_members, foreign_key: :subscriber_id, class_name: 'Member', dependent: :destroy 
  has_many :followers, through: :reverse_members

  #associations
  #dependent: :destroy, prevents orphan records

  has_many :posts, dependent: :destroy
  has_many :text_posts, dependent: :destroy
  has_many :image_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

    
  #returns true/false if the current user is following another user
=begin
  def following?(subscriber)
    subscribers.include?(subscriber)
  end

  #action to indicate that the current user is following another user

  def follow!(subscriber)
    #subscribers = []
    if subscriber != self && !following?(subscriber)
      subscribers << subscriber
    end
  end


  # timeline_user_ids
    
    #subscriber_ids + [id]
  #end
=end

 #######################################################################################################################

 

   #validations
   validates_presence_of :name
   validates :username,  presence: true, :case_sensitive => false    
   validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
   validate :validate_username
   validates :email, presence: true, uniqueness: true
   validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP,
     message: "must be a valid email address"
   



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login],
         reset_password_keys: [:login]



   # Link below for Devise custom login
   #https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address

  #login virtual attribute, setter
  attr_writer :login 
  

  def login
    @login || username || email
  end

  def self.find_authenticatable(login)
    where("lower(username) = :value OR email = :value", :value => login ).first
  end
  
    # function to handle user's login via email or username
    def self.find_for_database_authentication(conditions)
      conditions = conditions.dup
      login = conditions.delete(:login).downcase
      find_authenticatable(login)    
    end 
    
    def self.send_reset_password_instructions(conditions)
      recoverable = find_recoverable_or_init_with_errors(conditions)
  
      if recoverable.persisted?
        recoverable.send_reset_password_instructions
      end
  
      recoverable
    end
    
  
    def self.find_recoverable_or_init_with_errors(conditions)
      conditions = conditions.dup 
      login = conditions.delete(:login).downcase
      recoverable = find_authenticatable(login)
  
      unless recoverable
        recoverable = new(login: login)
        recoverable.errors.add(:login, login.present? ? :not_found : :blank)
      end
  
      recoverable
    end

    def validate_username
      if User.where(email: username).exists?
        errors.add(:username, :invalid)
      end
    end

  
    private 

    def proper_case
      self.name = name.capitalize
    end

end
