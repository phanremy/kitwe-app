# frozen_string_literal: true

module Profiles
  class BirthDates
    def initialize(profiles)
      @profiles = profiles
    end

    def call
      @profiles.where.not(birth_date: nil)
               .map { |profile| data(profile) }
               .sort_by { |p| p[:date] }
               .group_by { |p| p[:date].beginning_of_month }
    end

    private

    def data(profile)
      differential = profile.next_birthday == Date.today ? 0 : 1
      { id: profile.id,
        name: profile.designation,
        date: profile.next_birthday,
        age: profile.age + differential }
    end
  end
end
