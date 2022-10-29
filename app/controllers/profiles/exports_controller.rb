# frozen_string_literal: true

module Profiles
  class ExportsController < ApplicationController
    # TODO: check permission

    def create
      return render_error unless params[:profile_ids] && acceptable_profile_ids_count

      @data = Profiles::Export.new(params[:profile_ids]).call

      render turbo_stream: turbo_stream.append(
        :modal,
        partial: 'profiles/exports/create'
      )
    end

    private

    def acceptable_profile_ids_count
      params[:profile_ids].count.between?(1, 100)
    end

    def render_error
      flash.now[:alert] = 'You need to have between 1 to 100 filtered profiles'
      render_flash
    end
  end
end
