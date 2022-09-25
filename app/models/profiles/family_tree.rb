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

# [ { id: 1, pids: [2], name: "Amber McKenzie" },
#   { id: 2, pids: [1], name: "Ava Field" },
#   { id: 3, mid: 1, fid: 2, name: "Peter Stevens" } ]

# nodes: is the data source. The 'id' property is mandatory.
# pids: are the partner ids, represents connection between two partners (wife and husband).
# mid: mother id.
# fid: father id.
# gender: male or female.
# nodeBinding: 'name' property form the data source will be bound to 'field_0' ui element from the template.
