# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  type       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  #acts_as_votable
  #associations
  belongs_to :user
  has_many :comments, dependent: :destroy

  #validations
  validates :user_id, presence: true 
  validates :type, presence: true
  validates :content, presence: true

  scope :of_followed_users, -> (following_users) { where user_id: following_users } 
end
