# frozen_string_literal: true

# # top level documentation for Event
class Event < ApplicationRecord
  # has_paper_trail

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :profile_events,           dependent: :delete_all
  has_many :profiles,                 inverse_of: :events, through: :profile_events

  CATEGORIES = %i[birthday wedding death other_anniversary].freeze
  PRIVACIES = %w[public only_involved only_shared only_friends private].freeze
  FORM_ATTRIBUTES = %w[creator_id category privacy date].freeze

  enum category: Event::CATEGORIES.to_enum
  # enum category: Event::CATEGORIES.to_enum_hash

  validates :category,
            inclusion: { in: Event::CATEGORIES }

  validates :privacy,
            inclusion: { in: Event::PRIVACIES }
end
