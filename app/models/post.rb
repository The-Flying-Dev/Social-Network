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
  
  #associations
  belongs_to :user
  has_many :comments, dependent: :destroy

   #validations
   validates :user_id, presence: true 
   validates :type, presence: true

   # cached_comment_count 
    #Rails.cache.fetch [self, "comment_count"] do 
      #comments.size 
    #end
   #end
   
end
