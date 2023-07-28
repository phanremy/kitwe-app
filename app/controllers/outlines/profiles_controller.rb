# frozen_string_literal: true

module Outlines
  class ProfilesController < ApplicationController
    # before_action :set_profiles, only: %i[index birth_dates]
    # before_action :set_profile, only: %i[show edit]
    load_and_authorize_resource

    def show
    end

    def new
    end

    def create
    end

    def edit
      @profile = Profile.find(params[:id])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'outlines/profiles/edit',
            locals: { profile: @profile }
          )
        end
      end
    end

    def update
    end

    def destroy
    end
  end
end
