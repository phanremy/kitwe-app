# frozen_string_literal: true

# top level description of CouplesHelper
module CouplesHelper
  def couple_profiles
    profiles = Profile.accessible_by(current_ability).map { |profile| [profile.designation, profile.id] }
    profiles.push(['alone', nil])
  end
  # TO DO: do something to make dynamically show only available options for the second pairing
  # (cannot be paired with an already paired profile)
end
