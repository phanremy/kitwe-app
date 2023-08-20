# frozen_string_literal: true

module ImportMethods
  extend ActiveSupport::Concern

  included do
    def self.find_by_designation(value)
      # TODO: manage query chinese & arabic characters
      # designation_query(value).select { |profile| profile.designation == value }.first
      select { |profile| profile.designation == value }.first
    end
  end

  def partner_csv_designations
    results = couples.map { |couple| { designation: couple.other_partner(self)&.designation, status: couple.status } }
    if results.map { |result| result[:designation] }.include?(nil)
      results += [{ designation: Profile::NO_OTHER_PARTNER, status: Couple::DEFAULT }]
    end
    results.reject { |result| result[:designation].blank? }
           .map { |result| [result[:designation], '#', result[:status]].join }
           .join(';')
  end
end
