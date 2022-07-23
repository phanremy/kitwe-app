# frozen_string_literal: true

# top level description of ProfilesHelper
module ProfilesHelper
  def profile_privacies
    Profile::PRIVACIES.map { |option| [t(option, scope: :privacy), option] }
  end

  def create_google_calendar_birthday(profile)
    "https://calendar.google.com/calendar/u/0/r/eventedit?" \
      "#{"text=#{CGI.escape("#{profile.designation}'s birthday")}"}" \
      "&dates=#{CGI.escape(profile.next_birthday.strftime('%Y%m%d'))}/" \
      "#{CGI.escape(profile.next_birthday.strftime('%Y%m%d'))}" \
      "&ctz=#{Rails.application.config.time_zone}"
  end
end
