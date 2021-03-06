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
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
