# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  bio                    :text
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

  #hook method
  before_save :name_uppercase
  acts_as_voter

  #login virtual attribute, setter
  attr_writer :login   

  #associations  
  #dependent: :destroy, prevents orphan records by destroying any associated records if the user is destroyed 
  #dependent: :destroy, prevents orphan records

  has_many :posts, dependent: :destroy  
  has_many :image_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image 

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower 

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following 
  
 
  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
 

   #validations
   validate :validate_username #custom method
   validates :name, presence: true, uniqueness: true
   validates :username,  presence: true, length: { minimum: 4, maximum: 15 }, case_sensitive: false,
       format: { with: /^[a-zA-Z0-9_\.]*$/ , multiline: true }  
   validates :email, presence: true, uniqueness: true, 
             format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
   
   validate :image_type

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login], reset_password_keys: [:login]



  # Link below for Devise custom login
  #https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  

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

  #prevents users from creating usernames of email addresses that already exits in the DB
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, "This Username is not available")
    end
  end

  # To search for users
  def self.search(term)
    if term 
      where('name LIKE?',"%#{term}%")
    elsif term 
      where('username LIKE?',"%#{term}%")
    end
  end
  
  private 

  def name_uppercase
    self.name = name.capitalize
  end

  def image_type 
      if !image.content_type.in?(%('image/jpeg image/png image/gif'))
        errors.add(:image, 'File is not JPEF or PNG')
      end
    
  end

end
