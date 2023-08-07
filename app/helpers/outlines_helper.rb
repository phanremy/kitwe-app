# frozen_string_literal: true

module OutlinesHelper
  def display_section?(profile, list)
    can?(:manage, profile) || list&.any?
  end
end
