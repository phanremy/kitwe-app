# frozen_string_literal: true

module Outlines
  class ProfilesController < ApplicationController
    # before_action :set_profiles, only: %i[index birth_dates]
    # before_action :set_profile, only: %i[show edit]
    load_and_authorize_resource

    def new
      @profile = Profile.new
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'outlines/profiles/form',
            locals: { profile: @profile }
          )
        end
      end
    end

    def create
      @profile = Profile.new(profile_params)
      if @profile.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update(:outline, '')
          end
        end
      else
        flash.now[:error] = @profile.errors.full_messages
        render_flash
      end
    end

    def edit
      @profile = Profile.find(params[:id])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'outlines/profiles/form',
            locals: { profile: @profile }
          )
        end
      end
    end

    def update
      if @profile.update(profile_params)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update(:outline, '')
          end
        end
      else
        flash.now[:error] = @profile.errors.full_messages
        render_flash
      end
    end

    def destroy
    end

    private

    def profile_params
      params.require(:profile).permit(Profile::OUTLINE_FORM_ATTRIBUTES)
    end
  end
end
