# frozen_string_literal: true

# top level documentation for ProfilesController
class ProfilesController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_profile, except: %i[index new create birthdays]

  def index
    @profiles = Profile.accessible_by(current_ability)
  end

  def show
    # @events = @profile.events
  end

  def birthdays
    @birthdays = Profile.where.not(birth_date: nil)
                        .map { |profile| { name: profile.designation, date: profile.next_birthday } }
                        .sort_by { |p| p[:date] }
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      flash[:success] = 'Profile successfully created'
      redirect_to @profile
    else
      flash.now[:error] = @profile.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @profile.update(profile_params)
      flash.now[:success] = 'Profile was successfully updated'
      redirect_to @profile
    else
      flash.now[:error] = @profile.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @profile.destroy
      flash[:success] = 'Profile was successfully deleted.'
      redirect_to profiles_path
    else
      flash.now[:error] = 'Something went wrong'
      redirect_to @profile
    end
  end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(Profile::FORM_ATTRIBUTES)
  end
end
