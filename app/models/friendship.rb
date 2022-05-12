# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :integer
#  user_id    :integer
#
# Indexes
#
#  index_friendships_on_user_id  (user_id)
#
class Friendship < ApplicationRecord
  belongs_to :user

  

end
