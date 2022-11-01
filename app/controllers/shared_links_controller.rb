# frozen_string_literal: true

class SharedLinksController < ApplicationController
  authorize_resource class: false

  def create
    flash.now[:success] = 'Copied in clipboard'
    render_flash
  end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user)
  end
end
