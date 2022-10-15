# frozen_string_literal: true

module Profiles
  class SharedLinksController < ApplicationController
    def create
      flash.now[:success] = 'Copied in clipboard'
      render_flash
    end
  end
end
