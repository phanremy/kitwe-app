# frozen_string_literal: true

module Profiles
  class FamilyTreeBasic
    include Rails.application.routes.url_helpers

    def initialize(profile_id)
      @profile_id = profile_id
    end

    # [:id, :name, :pids, :mid, :fid, :url, :img]
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
