class Member < ApplicationRecord
  belongs_to :subscriber
  belongs_to :follower
end
