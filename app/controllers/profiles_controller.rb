# frozen_string_literal: true

class ProfilesController < ApplicationController
  include Tokenizer

  skip_before_action :authenticate_user!, only: %i[show children]

  before_action :validate_url_token, only: %i[show children]
  before_action :set_profiles, only: %i[index birth_dates]
  before_action :redirect_to_new, only: %i[index birth_dates]
  before_action :set_profile, only: %i[show edit]

  load_and_authorize_resource

  def index
    @profile_ids = @profiles.ids
    @pagy, @profiles = pagy(@profiles, items: 5)
  end

  def show
    @tokenized_url = tokenized_url('profile', id: @profile.id)
    @couples = Couple.includes(:profile1, :profile2)
                     .accessible_by(current_ability)
                     .related_to(params[:id])
    @children = @profile.children_profiles
  end

  def birth_dates
    @birth_dates_data = Profiles::BirthDates.new(@profiles).call
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      flash[:success] = I18n.t('profiles.create_success')
      create_success_redirection
    else
      flash.now[:error] = @profile.errors.full_messages
      render_flash
    end
  end

  def edit; end

  def update
    if @profile.update(profile_params)
      flash.now[:success] = I18n.t('profiles.update_success')
      redirect_to @profile
    else
      flash.now[:error] = @profile.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @profile.couples.count.positive?
      flash.now[:error] = I18n.t('profiles.with_couples_error')
      render_flash
    elsif @profile.destroy
      flash[:success] = I18n.t('profiles.destroy_success')
      redirect_to profiles_path
    else
      flash.now[:error] = I18n.t('general_error')
      render_flash
    end
  end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user, params[:token].present?)
  end

  def create_success_redirection
    if params[:coupled_with].present?
      Couple.create!(profile1_id: params[:coupled_with], profile2_id: @profile.id, creator_id: current_user.id)
      redirect_to profile_path(params[:coupled_with], profile_id: nil)
    else
      redirect_to @profile
    end
  end

  def set_profiles
    @profiles = Profile.accessible_by(current_ability).order(updated_at: :desc)
    @profiles = @profiles.designation_query(params[:search]) if params[:search].present?
    @profiles = @profiles.birth_date_query(params[:birthday]) if params[:birthday].present?
    @profiles = @profiles.gender_query(params[:gender]) if params[:gender].present?
    @profiles = @profiles.category_query(params[:category]) if params[:category].present?
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(Profile::FORM_ATTRIBUTES)
  end

  def redirect_to_new
    redirect_to new_profile_path if @profiles.empty? && params[:commit] != 'Filter'
  end
end
