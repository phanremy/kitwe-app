# frozen_string_literal: true

require 'csv'

module Profiles
  class Import
    attr_reader :file, :errors, :imported_profile_count

    def initialize(file, current_user)
      @file = file
      @errors = []
      @imported_profile_count = 0
      @options = { col_sep: "\;", headers: :first_row }
      @profiles = Profile.includes(:creator, :couples1, :couples2).where(creator: current_user)
      @couples = Couple.where(creator: current_user)
    end

    def call
      ActiveRecord::Base.transaction do
        CSV.foreach(file.path, **@options) { |row| import(row) }
      end
      @imported_profile_count = @find_or_build_profile.count
      @errors = @errors.first(10) + ['more'] if @errors.count > 10
    rescue StandardError => e
      @errors.push(e)
    end

    private

    def import(row)
      profile = import_profiles(row)
      import_couples(profile, row)
    end

    def import_profiles(row)
      profile = find_or_build_profile(row['Designation'])
      profile.assign_attributes(Profile::CSV_HEADERS.compact
                                                    .to_h { |k, v| [v, row[k]] })

      profile.parents = find_or_build_parents(row['Parents'])
      profile.tap(&:save!)
      # TODO: manage photo
    end

    def find_or_build_profile(designation)
      @find_or_build_profile ||= {}
      @find_or_build_profile[designation] ||= begin
        @profiles.find_by_designation(designation) || @profiles.build(pseudo: designation)
      rescue StandardError => e
        @errors.push(e)
      end
    end

    def find_or_build_parents(parents)
      return if parents.blank?

      partner1_designation, partner2_designation = parents.split(';')
      partner1 = find_or_create_profile(partner1_designation)
      partner2 = partner2_designation == Profile::WITH_SELF_CAPTION ? nil : find_or_create_profile(partner2_designation)
      @couples.search_couple(partner1, partner2) || @couples.build(profile1: partner1, profile2: partner2).tap(&:save!)
    end

    def import_couples(partner1, row)
      return if row['Couples'].blank?

      row['Couples'].split(';').each do |couple|
        partner2 = couple == Profile::WITH_SELF_CAPTION ? nil : find_or_create_profile(couple)
        @couples.search_couple(partner1, partner2) ||
          @couples.build(profile1: partner1, profile2: partner2).save!
      end
    end

    def find_or_create_profile(designation)
      find_or_build_profile(designation).tap do |profile|
        profile.save! unless profile.persisted?
      end
    end
  end
end
