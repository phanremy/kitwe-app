# frozen_string_literal: true

module Profiles
  class FiltersController < ApplicationController
    def new
      render turbo_stream: turbo_stream.append(
        :filter,
        partial: 'profiles/filters/new'
      )
    end
  end
end
