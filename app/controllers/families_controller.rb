# frozen_string_literal: true

class FamiliesController < ApplicationController
  include Tokenizer

  skip_before_action :authenticate_user!, only: %i[index]
  before_action :validate_url_token, only: %i[index]
  authorize_resource class: false

  def index
    @profile = Profile.find_by(id: params[:profile_id])
    @tokenized_url = tokenized_url('families', profile_id: @profile.id)
  end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user, params[:token])
  end
end
