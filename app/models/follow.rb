# frozen_string_literal: true

# top level documentation for Follow
class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :profile
end
