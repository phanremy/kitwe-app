# frozen_string_literal: true

module ImportMethods
  extend ActiveSupport::Concern

  included do
    def self.find_by_designation(value)
      # TODO: manage query chinese characters
      # designation_query(value).select { |profile| profile.designation == value }.first
      select { |profile| profile.designation == value }.first
    end
  end

  def partner_csv_designations
    ids = partner_ids
    designations = Profile.where(id: ids)
                          .map(&:designation)
    designations += [Profile::WITH_SELF_CAPTION] if ids.include?(nil)
    designations.join(';')
  end
end
