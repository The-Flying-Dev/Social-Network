# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  follower_id   :integer
#  subscriber_id :integer
#
# Indexes
#
#  index_members_on_follower_id    (follower_id)
#  index_members_on_subscriber_id  (subscriber_id)
#
class Member < ApplicationRecord
  belongs_to :subscriber, class_name: "User"
  belongs_to :follower, class_name: "User"
end
