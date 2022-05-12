# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
class Comment < ApplicationRecord

  acts_as_votable
  #associations
  belongs_to :post, touch: true
  belongs_to :user

  #validations  
  validates :user_id, presence: true 
  validates :post_id, presence: true 
  validates :content, presence: true

  after_commit :create_notifications, on: :create 

  private 

  def create_notifications
    Notification.create do | notification | 
      notification.notify_type = 'post'
      notification.actor = self.user
      notification.user = self.post.user
      notification.target = self
      notification.second_target = self.post
    end
  end
end
