# frozen_string_literal: true

module Profiles
  class FamilyTree
    def initialize(profile_id)
      @profile_id = profile_id
    end

    def call
      return if @profile_id.blank?

      @profile_id
    end
  end
end
