# frozen_string_literal: true

module Profiles
  class FiltersController < ApplicationController
    authorize_resource class: false

    def new
      render turbo_stream: turbo_stream.append(
        :modal,
        partial: 'profiles/filters/new'
      )
    end

    private

    def current_ability
      @current_ability ||= ::Ability.new(current_user)
    end
  end
end
