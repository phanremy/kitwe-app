# frozen_string_literal: true

class ModalSharedLinksController < ApplicationController
  # TODO: check permission

  def create
    flash.now[:success] = 'Copied in clipboard'
    render_modal_flash
  end
end
