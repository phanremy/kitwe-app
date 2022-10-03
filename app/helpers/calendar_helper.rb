# frozen_string_literal: true

# top level description of CouplesHelper
module CalendarHelper
  def create_google_calendar_birthday(profile)
    "https://calendar.google.com/calendar/u/0/r/eventedit?" \
      "#{"text=#{CGI.escape("#{profile.designation}'s birthday")}"}" \
      "&dates=#{CGI.escape(profile.next_birthday.strftime('%Y%m%d'))}/" \
      "#{CGI.escape(profile.next_birthday.strftime('%Y%m%d'))}" \
      "&ctz=#{Rails.application.config.time_zone}"
  end

  def create_google_calendar_wedding_anniversary(profile)
    "https://calendar.google.com/calendar/u/0/r/eventedit?" \
      "#{"text=#{CGI.escape("#{profile.designation}'s wedding")}"}" \
      "&dates=#{CGI.escape(profile.next_wedding_anniversary.strftime('%Y%m%d'))}/" \
      "#{CGI.escape(profile.next_wedding_anniversary.strftime('%Y%m%d'))}" \
      "&ctz=#{Rails.application.config.time_zone}"
  end
end
