# frozen_string_literal: true

module Profiles
  class FiltersController < ApplicationController
    # TODO: check permission

    def new
      render turbo_stream: turbo_stream.append(
        :modal,
        partial: 'profiles/filters/new'
      )
    end
  end
end
