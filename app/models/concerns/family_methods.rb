# frozen_string_literal: true

module FamilyMethods
  extend ActiveSupport::Concern

  def partner_ids
    (Couple.where(profile1_id: self)
           .or(Couple.where(profile2_id: self))
           .pluck(:profile1_id, :profile2_id)
           .flatten - [id]).compact
  end

  def couples
    [couples1, couples2].flatten
  end

  def sibling_profiles
    return [] unless parents

    parents.children.where.not(id: id)
  end

  def parents_profiles
    return [] if parents.nil?

    Profile.where(id: parents_ids)
  end

  def children_profiles
    couples.map(&:children)
           .flatten
           .sort_by { |profile| [profile.birth_date ? 1 : 0, profile.birth_date] }
  end

  def couples_family_links
    couples.map { |couple| { id: couple.other_partner(self)&.id.to_s, type: couple.status } }
           .reject { |data| data[:id].blank? }
           .sort_by { |data| data[:id] }
  end
end
