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

  def profile_gender_attribute_options
    select_options('gender', %w[male female], @profile&.gender)
  end

  def profile_gender_search_options(gender_option)
    select_options('gender', %w[not_specified male female], gender_option)
  end

  def profile_category_attribute_options
    select_options('category', %w[family friend colleague], @profile&.category || category_option)
  end

  def profile_category_search_options(category_option)
    select_options('category', %w[without family friend colleague], @profile&.category || category_option)
  end

  def profile_birth_date_search_options(birth_date_option)
    select_options('birth_date', %w[without with centenarian], birth_date_option)
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

  private

  def select_options(kind, options, selected_option)
    options = [nil] + options.map { |option| [I18n.t("profiles.#{kind}.#{option}"), option] }

    options_for_select(options, selected_option)
  end
end
