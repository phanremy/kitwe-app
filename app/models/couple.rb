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
  validate :couple_with_oneself?

  scope :related_to, lambda { |value|
                       where(profile1_id: value).or(where(profile2_id: value))
                     }

  # TODO: do something to check profile_id pairing in both ways

  def couple_with_oneself?
    return unless profile1_id == profile2_id

    errors.add :base, "Partner 1 is same as partner 2"
  end

  def partners
    [profile1, profile2]
  end

  def designation
    partner1 = profile1.designation
    partner2 = profile2&.designation
    profile2_id ? [partner1, partner2].join(' & ') : partner1
  end
end
