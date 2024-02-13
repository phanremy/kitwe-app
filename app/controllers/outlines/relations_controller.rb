# frozen_string_literal: true

module Outlines
  class RelationsController < ApplicationController
    authorize_resource class: false
    skip_before_action :authenticate_user!, only: %i[new]

    def new
      @profile = Profile.find(params[:profile_id])

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :modal,
            partial: 'outlines/relations/input_card',
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
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :relation_output,
            partial: 'outlines/relations/output_card',
            locals: { profile1_id: params[:profile1_id], profile2_id: params[:profile2_id] }
          )
        end
      end
    end
  end
end
