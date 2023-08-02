# frozen_string_literal: true

class ParentProfile < ApplicationRecord
  belongs_to :parent, class_name: 'Profile'
  belongs_to :profile, class_name: 'Profile'
end
