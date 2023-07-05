# frozen_string_literal: true

module FamilyMethods
  extend ActiveSupport::Concern

  included do
    def partner_ids
      Couple.where(profile1_id: self)
            .or(Couple.where(profile2_id: self))
            .pluck(:profile1_id, :profile2_id)
            .flatten - [id]
    end

    def couples
      [couples1, couples2].flatten
    end

    def sibling_profiles
      return [] unless parents

      parents.children
    end

    def parents_profiles
      return [] if parents.nil?

      Profile.where(id: parents_ids)
    end

    def children_profiles
      couples.map(&:children).flatten
    end
  end
end
