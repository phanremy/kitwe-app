# frozen_string_literal: true

class SharedLinksController < ApplicationController
  # TODO: check permission

  def create
    flash.now[:success] = 'Copied in clipboard'
    render_flash
  end
end
