# frozen_string_literal: true

# top level documentation for ParentProfile
class ParentProfile < ApplicationRecord
  belongs_to :parent, class_name: 'Profile'
  belongs_to :profile, class_name: 'Profile'
end
