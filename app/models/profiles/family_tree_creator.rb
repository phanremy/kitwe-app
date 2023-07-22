# frozen_string_literal: true

module Profiles
  class FamilyTreeCreator
    include Rails.application.routes.url_helpers

    def initialize(profile_id)
      @profile_id = profile_id
    end

    # [:id, :gender, :parents, :siblings, :spouses, :children]
    def call
      profile_full_family.map do |profile|
        {
          id: profile.id.to_s,
          name: profile.designation,
          gender: profile.gender || 'male',
          url: host ? profile_url(profile, host: host) : profile_path(profile),
          img: profile.small_photo_url
        }.merge(family_links(profile))
      end
    end

    private

    def family_links(profile)
      {
        parents: profile.parents_profiles.map { |parent| { id: parent.id.to_s, type: 'blood' } },
        siblings: profile.sibling_profiles.map { |sibling| { id: sibling.id.to_s, type: 'blood' } },
        spouses: profile.partner_ids.map { |id| { id: id.to_s, type: 'married' } },
        children: profile.children_profiles.map { |child| { id: child.id.to_s, type: 'blood' } }
      }
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
