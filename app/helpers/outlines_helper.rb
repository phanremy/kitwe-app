# frozen_string_literal: true

module OutlinesHelper
  def display_section?(profile, list)
    can?(:manage, profile) || list&.any?
  end

  def couple_status(status)
    return if status == Couple::DEFAULT

    ['(', I18n.t("couples.status.#{status}"), ')'].join
  end
end
