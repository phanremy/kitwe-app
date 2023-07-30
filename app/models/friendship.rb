# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
  belongs_to :addressee, class_name: 'User', foreign_key: 'addressee_id'
  belongs_to :specifier, class_name: 'User', foreign_key: 'specifier_id'

  STATUS = %w[requested accepted rejected blocked].freeze

  validates :status,
            inclusion: { in: Friendship::STATUS }
end
