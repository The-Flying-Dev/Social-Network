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
class TextPost < Post #single table inheritance

  #validation
  validates :content, presence: true
end

