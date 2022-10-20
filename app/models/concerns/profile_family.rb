# frozen_string_literal: true

module ProfileFamily
  extend ActiveSupport::Concern

  included do
    MAX_DEGREE_OF_SEPARATION = 10

    def couples
      [couples1, couples2].flatten
    end

    def partner_ids
      Couple.where(profile1_id: self)
            .or(Couple.where(profile2_id: self))
            .pluck(:profile1_id, :profile2_id)
            .flatten - [id]
    end

    def sibling_profiles
      return unless parents

      parents.children
    end

    def parents_profiles
      return nil if parents.nil?

      Profile.where(id: parents_ids)
    end

    def children_profiles
      couples.map(&:children).flatten
    end

    def close_family
      Profile.includes(:parents, :photo_attachment, couples1: :children, couples2: :children).where(id: close_family_ids)
    end

    def full_family
      data = close_family

      (1..Profile::MAX_DEGREE_OF_SEPARATION).to_a.each do |degree|
        temp = Profile.where(id: data.map(&:close_family).flatten.pluck(:id).uniq)

        return temp if data.count == temp.count

        data = temp
      end

      data
    end

    private

    def parents_ids
      [parents&.profile1_id, parents&.profile2_id]
    end

    def close_family_ids
      [id,
       sibling_profiles&.pluck(:id),
       partner_ids,
       parents_ids,
       children_profiles&.pluck(:id)].flatten.uniq
    end
  end
end
