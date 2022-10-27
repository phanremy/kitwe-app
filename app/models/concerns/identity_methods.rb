# frozen_string_literal: true

module IdentityMethods
  extend ActiveSupport::Concern

  included do
    def age
      return if birth_date.nil?

      dob = birth_date
      now = Time.now.utc.to_date
      differential = now.month > dob.month || (now.month == dob.month && now.day >= dob.day) ? 0 : 1
      now.year - dob.year - differential
    end

    def full_name
      [first_name, last_name].join(' ').strip
    end

    def designation
      option_bis = email.present? ? email : phone
      option = full_name.present? ? full_name : option_bis
      pseudo.present? ? pseudo : option
    end

    def full_designation
      return designation unless full_name.present? && pseudo.present?

      ["#{first_name} ",
       "\"#{pseudo}\"",
       " #{last_name}"].join(' ').strip
    end
  end
end
