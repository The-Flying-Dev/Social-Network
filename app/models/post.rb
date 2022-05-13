# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  content                 :text
#  type                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  acts_as_votable 
  
  #associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images    

  #validations
  validates :user_id, presence: true   
  validates :content, length: { minimum: 1 }, allow_blank: true 
  validate :image_type  

  scope :of_followed_users, -> (following_users) { where user_id: following_users } 

  private 


  def image_type 
    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/png image/gif'))
        errors.add(:images, 'File is not JPEF or PNG')
      end
    end
  end
end
