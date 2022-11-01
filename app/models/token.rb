# frozen_string_literal: true

# top level documentation for Token
class Token < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, :content, presence: true
  validates :name, uniqueness: true

  CATEGORIES = %w[profile_import].freeze

  validates :category,
            inclusion: { in: Token::CATEGORIES }
end
