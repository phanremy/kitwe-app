# frozen_string_literal: true

class SharedLinksController < ApplicationController
  def create
    flash.now[:success] = 'Copied in clipboard'
    render_flash
  end
end
