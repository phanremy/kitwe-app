# frozen_string_literal: true

module Outlines
  class RelationsController < ApplicationController
    include TurboOutline

    authorize_resource class: false

    def new
      @profile = Profile.find(params[:profile_id])

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'outlines/relations/card',
            locals: { profile: @profile }
          )
        end
      end
    end

    def edit
      @profile = Profile.find(params[:profile_id])

      render partial: 'outlines/relations/form', locals: { profile: @profile, profiles: @profile.full_family }
    end

    def update
      @profile1 = Profile.find(params[:profile1_id])
      @profile2 = Profile.find(params[:profile2_id])
      if true
        family_tree_turbo_response(success_message: I18n.t('profiles.create_success'))
      else
        flash.now[:error] = @profile.errors.full_messages
        render_flash
      end
    end
  end
end
