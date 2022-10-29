# frozen_string_literal: true

# top level description of ProfilesHelper
module ProfilesHelper
  def profile_id_detected
    (params[:controller] == 'profiles' && params[:action] == 'show') || params[:profile_id]
  end

  def profile_privacy_options
    Profile::PRIVACIES.map { |option| [t(option, scope: :privacy), option] }
  end

  def profile_parents_options(couple_id = nil)
    options = [nil] +
              Couple.includes(:profile1, :profile2)
                    .accessible_by(current_ability)
                    .map { |couple| [couple.designation, couple.id] }

    options_for_select(options, @profile.parents&.id || couple_id)
  end

  def profile_category_attribute_options(category = nil)
    profile_category_options(%w[family friend colleague], category)
  end

  def profile_category_search_options(category = nil)
    profile_category_options(%w[without family friend colleague], category)
  end

  def profile_category_options(options, category)
    options = [nil] + options.map { |option| [I18n.t("profiles.category.#{option}"), option] }

    options_for_select(options, @profile&.category || category)
  end

  def profile_birthday_options(birthday_option)
    options = [nil] + %w[without with centenarian]
              .map { |option| [I18n.t("profiles.birthday.#{option}"), option] }

    options_for_select(options, birthday_option)
  end

  def couple_profile_options(profile1_id:, profile2_id:, blocked: true)
    collection = if blocked
                   [Profile.find(profile1_id)]
                 else
                   [nil] + Profile.accessible_by(current_ability).where.not(id: profile1_id)
                 end

    first = blocked ? profile1_id : profile2_id

    options_for_select(collection.map { |profile| [profile&.designation, profile&.id] }, first)
  end
  # TO DO: do something to make dynamically show only available options for the second pairing
  # (cannot be paired with an already paired profile)

  def child_of(parents)
    content_tag(:div, class: 'flex') do
      safe_join([I18n.t('child_of'),
                 partners_links(parents)])
    end
  end
end
