# frozen_string_literal: true

require 'csv'

module Profiles
  class Export
    def initialize(profile_ids)
      @profile_ids = profile_ids
    end

    def call
      profiles = Profile.includes(:creator, :parents, :photo_attachment, :couples1, :couples2)
                        .where(id: @profile_ids)

      CSV.generate(col_sep: "\;") do |csv|
        csv << Profile::CSV_HEADERS.keys
        profiles.each do |profile|
          csv << row_infos(profile)
        end
      end
    end

    private

    def row_infos(profile)
      [profile.designation, profile.pseudo, profile.first_name, profile.last_name, profile.email, profile.phone,
       profile.gender, profile.birth_date, profile.parents&.csv_designation, profile.partner_csv_designations,
       profile.category, profile.small_photo_url, profile.creator.email]
    end
  end
end
