# == Schema Information
#
# Table name: notifications
#
#  id                 :integer          not null, primary key
#  notify_type        :string           not null
#  read_at            :datetime
#  second_target_type :string
#  target_type        :string
#  third_target_type  :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  actor_id           :bigint
#  second_target_id   :bigint
#  target_id          :bigint
#  third_target_id    :bigint
#  user_id            :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id                  (user_id)
#  index_notifications_on_user_id_and_notify_type  (user_id,notify_type)
#
class Notification < ActiveRecord::Base
  include Notifications::Model

  # Write your custom methods...
end
