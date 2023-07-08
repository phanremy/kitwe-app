# frozen_string_literal: true

# top level documentation for ProfilesController
class ProfilesController < ApplicationController
  include Tokenizer

  skip_before_action :authenticate_user!, only: %i[show children]

  before_action :validate_url_token, only: %i[show children]
  before_action :set_profiles, only: %i[index birth_dates]
  before_action :set_profile, except: %i[index new create birth_dates children]

  load_and_authorize_resource

  def index
    @profile_ids = @profiles.ids
    @pagy, @profiles = pagy(@profiles, items: 5)
  end

  def show
    @tokenized_url = tokenized_url('profile', id: @profile.id)
  end
  # @events = @profile.events

  def birth_dates
    @birth_dates_data = Profiles::BirthDates.new(@profiles).call
  end

  def children
    if params[:profile_id]
      profile = Profile.find(params[:profile_id])
      @children = profile.children_profiles
      @couples = profile.couples
    else
      @children = @profiles.where.not(parents_id: nil)
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      flash[:success] = 'Profile successfully created'
      create_success_redirection
    else
      flash.now[:error] = @profile.errors.full_messages
      render_flash
    end
  end

  def edit; end

  def update
    if @profile.update(profile_params)
      flash.now[:success] = 'Profile was successfully updated'
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
      redirect_to couples_path(profile_id: params[:coupled_with])
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
end
