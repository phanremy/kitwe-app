# frozen_string_literal: true

class DownloadsController < ApplicationController
  authorize_resource class: false

  def create
    respond_to do |format|
      format.html
      format.csv { send_data params[:data], filename: params[:file_name] }
    end
  end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user)
  end
end
