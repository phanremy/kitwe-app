# frozen_string_literal: true

module Profiles
  class FamilyTree
    include Rails.application.routes.url_helpers

    def initialize(profile_id)
      @profile_id = profile_id
    end

    def call
      return if @profile_id.blank?

      profile_full_family.map do |profile|
        { id: profile.id,
          name: profile.designation,
          pids: profile.partner_ids,
          mid: profile.parents_profiles&.first&.id,
          fid: profile.parents_profiles&.second&.id,
          url: host ? profile_url(profile, host: host) : profile_path(profile),
          img: profile.small_photo_url }
      end
    end

    def host
      @host ||= ENV.fetch('HOST', nil)
    end

    def profile_full_family
      Profile.includes(:parents, :photo_attachment, couples1: :children, couples2: :children)
             .find(@profile_id)
             .full_family
    end

    def profile_close_family
      Profile.includes(:parents, :photo_attachment, couples1: :children, couples2: :children)
             .find(@profile_id)
             .close_family
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
