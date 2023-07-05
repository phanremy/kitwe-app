# frozen_string_literal: true

# # top level documentation for FamiliesController
class FamiliesController < ApplicationController
  include Tokenizer

  skip_before_action :authenticate_user!, only: %i[index tree]
  before_action :validate_url_token, only: %i[index tree]
  authorize_resource class: false

  def index; end

  def tree
    return unless params[:profile_id]

    @data = Profiles::FamilyTreeCreator.new(params[:profile_id]).call
  end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user, params[:token])
  end

  def couple_params
    params.require(:couple).permit(:profile1_id, :profile2_id, :creator_id)
  end
end
