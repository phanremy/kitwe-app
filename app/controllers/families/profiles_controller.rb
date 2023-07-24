# frozen_string_literal: true

module Families
  class ProfilesController < ApplicationController
    def edit
      @profile = Profile.find(params[:id])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'families/profiles/edit',
            locals: { profile: @profile }
          )
        end
      end
    end
  end
end
