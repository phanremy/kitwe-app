# frozen_string_literal: true

module Profiles
  class Birthdays
    def initialize(profiles)
      @profiles = profiles
    end

    def call
      @profiles.where.not(birth_date: nil)
               .map { |profile| data(profile) }
               .sort_by { |p| p[:date] }
               .group_by { |p| p[:date].month }
    end

    private

    def data(profile)
      { id: profile.id,
        name: profile.designation,
        date: profile.next_birthday }
    end
  end
end
