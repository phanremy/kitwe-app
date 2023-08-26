# frozen_string_literal: true

# top level description of ProfilesHelper
module ProfilesHelper
  def detect_profile_id
    if params[:controller] == 'profiles' && params[:action] == 'show'
      #  (params[:controller] == 'profiles/cards' && params[:action] == 'show')
      params[:id]
    else
      params[:profile_id]
    end
  end

  def profile_id_detected
    (params[:controller] == 'profiles' && params[:action] == 'show') || params[:profile_id]
    # (params[:controller] == 'profiles/cards' && params[:action] == 'show') ||
  end

  def profile_parents_options(couple_id = nil)
    options = ([nil] + Couple.includes(:profile1, :profile2).accessible_by(current_ability))
              .map { |couple| [couple&.designation || ' ', couple&.id] }

    options_for_select(options, @profile.parents&.id || couple_id)
  end

  def profile_gender_attribute_options(profile_id = nil)
    gender = Profile.find_by(id: profile_id)&.gender == 'male' ? 'female' : 'male'
    select_options('profiles.gender', %w[male female], @profile&.gender || gender)
  end

  def profile_gender_search_options(gender_option)
    select_options('profiles.gender', %w[not_specified male female], gender_option)
  end

  def profile_category_attribute_options
    select_options('profiles.category', %w[family friend colleague], @profile&.category || category_option)
  end

  def profile_category_search_options(category_option)
    select_options('profiles.category', %w[without family friend colleague], @profile&.category || category_option)
  end

  def profile_birth_date_search_options(birth_date_option)
    select_options('profiles.birth_date', %w[without with centenarian], birth_date_option)
  end

  def profile_search_options(excluded_id:, default_id:, profiles: Profile.accessible_by(current_ability))
    collection = [nil] + profiles.where.not(id: excluded_id)

    options_for_select(collection.map { |profile| [profile&.designation || ' ', profile&.id] }, default_id)
  end

  def couple_status_attribute_options(status_option)
    select_options('couples.status', Couple::STATUS, status_option)
  end

  def select_options(scope, options, selected_option)
    options = [nil] + options.map { |option| [I18n.t("#{scope}.#{option}") || ' ', option] }

    options_for_select(options, selected_option)
  end
end
