# frozen_string_literal: true

class ModalSharedLinksController < ApplicationController
  authorize_resource class: false

  def create
    flash.now[:success] = 'Copied in clipboard'
    render_modal_flash
  en

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user)
  end
end
