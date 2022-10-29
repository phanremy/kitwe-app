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
        CSV.foreach(file.path, **@options) { |row| import_profiles(row) }
        CSV.foreach(file.path, **@options) { |row| import_relationships(row) }
      end
      @imported_profile_count = @find_or_create_profile.count
      @errors = @errors.first(10) + ['more'] if @errors.count > 10
    end

    private

    def import_profiles(row)
      profile = find_or_build_profile(row['Designation'])
      profile.assign_attributes(Profile::CSV_HEADERS.compact
                                                    .to_h { |k, v| [v, row[k]] })
      profile.save!
      # TODO: delete couples?
      # profile.couples1.destroy_all
      # profile.couples2.destroy_all
      # TODO: manage photo
    end

    def find_or_build_profile(designation)
      @find_or_create_profile ||= {}
      @find_or_create_profile[designation] ||= begin
        @profiles.find_by_designation(designation) || @profiles.build(pseudo: designation)
      rescue StandardError => e
        @errors.push(e)
      end
    end

    def find_or_create_profile(designation)
      find_or_build_profile(designation).tap do |profile|
        profile.save! unless profile.persisted?
      end
    end

    def import_relationships(row)
      # TODO: manage parents, couples
      partner1 = find_or_create_profile(row['Designation'])
      row['Couples'].split(';').each do |couple|
        partner2 = couple == Profile::WITH_SELF_CAPTION ? nil : find_or_create_profile(couple)
        @couples.search_couple(partner1, partner2) ||
          @couples.build(profile1: partner1, profile2: partner2).save!
      end
    end
  end
end
