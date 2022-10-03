# frozen_string_literal: true

# top level description of CouplesHelper
module CouplesHelper
  def profile_parents_options
    couples = Couple.accessible_by(current_ability).map { |couple| [couple.designation, couple.id] }
    couples.push([nil, nil])
  end

  def couple_profile_options(profile_id = nil)
    options = Profile.accessible_by(current_ability).map { |profile| [profile.designation, profile.id] }
                     .push([nil, nil])

    options_for_select(options, profile_id)
  end
  # TO DO: do something to make dynamically show only available options for the second pairing
  # (cannot be paired with an already paired profile)
end
