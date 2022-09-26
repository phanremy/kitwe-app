# frozen_string_literal: true

class Couple < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :profile1, class_name: 'Profile', foreign_key: 'profile1_id'
  belongs_to :profile2, class_name: 'Profile', foreign_key: 'profile2_id', optional: true

  has_many :children, class_name: 'Profile', foreign_key: 'parents_id'

  validates :profile1_id,
            presence: true,
            uniqueness: { scope: :profile2_id,
                          message: :uniqueness }

  # TODO: do something to check profile_id pairing in both ways

  def designation
    partner1 = profile1.designation
    partner2 = profile2&.designation
    profile2_id ? [partner1, partner2].join(' & ') : partner1
  end
end
