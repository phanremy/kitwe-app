# frozen_string_literal: true

module Outlines
  class RelationsController < ApplicationController
    include TurboOutline
    load_and_authorize_resource

    def new
      @profile = Profile.new
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'outlines/relations/form',
            locals: { profile: @profile }
          )
        end
      end
    end

    def create
      @profile = Profile.new(profile_params)
      if true
        family_tree_turbo_response(success_message: I18n.t('profiles.create_success'))
      else
        flash.now[:error] = @profile.errors.full_messages
        render_flash
      end
    end
  end
end
