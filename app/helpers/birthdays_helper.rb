# frozen_string_literal: true

module BirthdaysHelper
  def year_month_label(beginning_of_month)
    [
      Date::MONTHNAMES[beginning_of_month.month],
      beginning_of_month.month == 1 ? beginning_of_month.year : nil
    ].join(' ')
  end
end
