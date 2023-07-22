# frozen_string_literal: true

# # top level documentation for FamiliesController
class FamiliesController < ApplicationController
  include Tokenizer

  skip_before_action :authenticate_user!, only: %i[index]
  before_action :validate_url_token, only: %i[index]
  authorize_resource class: false

  def index; end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user, params[:token])
  end
end
