# frozen_string_literal: true

# top level description of CouplesHelper
module CouplesHelper
  def profile_parents_options
    couples = Couple.accessible_by(current_ability).map { |couple| [couple.designation, couple.id] }
    couples.push([nil, nil])
  end

  def couple_profile_options
    profiles = Profile.accessible_by(current_ability).map { |profile| [profile.designation, profile.id] }
    profiles.push([nil, nil])
  end
  # TO DO: do something to make dynamically show only available options for the second pairing
  # (cannot be paired with an already paired profile)
end
