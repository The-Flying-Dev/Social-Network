# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

  

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

  validates :email, presence: true, uniqueness: true
  
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
end
