# frozen_string_literal: true

# # top level documentation for FamiliesController
class FamiliesController < ApplicationController
  include Tokenizer

  skip_before_action :authenticate_user!, only: %i[index]
  before_action :validate_url_token, only: %i[index]
  authorize_resource class: false

  def index; end

  # def create
  #   render turbo_stream: turbo_stream.update(
  #     :family_tree,
  #     partial: 'family_tree',
  #     locals: { data: Profiles::FamilyTree.new(params[:family_profile_id]).call,
  #               profile_id: params[:family_profile_id] }
  #   )
  # end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user, params[:token])
  end

  def couple_params
    params.require(:couple).permit(:profile1_id, :profile2_id, :creator_id)
  end
end
