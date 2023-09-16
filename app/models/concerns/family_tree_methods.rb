# frozen_string_literal: true

module FamilyTreeMethods
  extend ActiveSupport::Concern

  def close_family
    Profile.includes(:parents, :photo_attachment, couples1: :children, couples2: :children)
           .where(id: close_family_ids)
  end

  def full_family
    data = close_family

    (1..Profile::MAX_DEGREE_OF_SEPARATION).to_a.each do |_degree|
      temp = Profile.where(id: data.map(&:close_family).flatten.pluck(:id).uniq)

      return temp if data.count == temp.count

      data = temp
    end

    data
  end

  def full_family_until(profile)
    data = close_family

    (1..Profile::MAX_DEGREE_OF_SEPARATION).to_a.each do |_degree|
      temp = Profile.where(id: data.map(&:close_family).flatten.pluck(:id).uniq)

      return temp if data.count == temp.count || temp.include?(profile)

      data = temp
    end

    data
  end

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

  def default_photo_url
    ActionController::Base.helpers.asset_path('user.png')
  end
end
