# frozen_string_literal: true

module Outlines
  class ProfilesController < ApplicationController
    include TurboOutline
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
        if params[:coupled_with].present?
          Couple.create!(profile1_id: params[:coupled_with], profile2_id: @profile.id, creator_id: current_user.id)
        end
        family_tree_turbo_response(success_message: I18n.t('profiles.create_success'))
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
        family_tree_turbo_response(success_message: I18n.t('profiles.update_success'))
      else
        flash.now[:error] = @profile.errors.full_messages
        render_flash
      end
    end

    # TODO: Implement destroy
    def destroy
      set_profiles
      if @profile_to_destroy.couples.count.positive?
        flash.now[:error] = I18n.t('profiles.with_couples_error')
        render_flash
      elsif @profile_to_destroy.destroy
        family_tree_turbo_response(success_message: I18n.t('profiles.destroy_success'))
      else
        flash.now[:error] = I18n.t('general_error')
        render_flash
      end
    end

    private

    def set_profiles
      @profile = Profile.find(params[:profile_id])
      @profile_to_destroy = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(Profile::OUTLINE_FORM_ATTRIBUTES)
    end
  end
end
