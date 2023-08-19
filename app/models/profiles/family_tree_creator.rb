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
        profile_info(profile)
          .merge(family_links(profile))
      end
    rescue StandardError => e
      return e
    end

    private

    def profile_info(profile)
      {
        id: profile.id.to_s,
        name: profile.designation,
        gender: profile.gender,
        deceased: profile.deceased,
        # url: host ? profile_url(profile, host: host) : profile_path(profile),
        img: profile.small_photo_url
      }
    end

    def family_links(profile)
      result = {
        parents: profile.parents_profiles.map { |parent| { id: parent.id.to_s, type: 'blood' } },
        siblings: profile.sibling_profiles.map { |sibling| { id: sibling.id.to_s, type: 'blood' } },
        spouses: profile.couples_family_links,
        children: profile.children_profiles.map { |child| { id: child.id.to_s, type: 'blood' } }
      }

      return result if non_duplicate_ids(result)

      raise 'Strange tree'
    end

    def non_duplicate_ids(result)
      ids = result.values.flatten.map { |hash| hash[:id] }

      ids.uniq.count == ids.count
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
