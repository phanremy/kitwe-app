# frozen_string_literal: true

module Families
  class TreesController < ApplicationController
    include Tokenizer

    skip_before_action :authenticate_user!, only: %i[show]
    before_action :validate_url_token, only: %i[show]
    authorize_resource class: false

    def show
      return unless params[:profile_id]

      @data = Profiles::FamilyTreeCreator.new(params[:profile_id]).call
    end

    private

    def current_ability
      @current_ability ||= ::Ability.new(current_user, params[:token])
    end
  end
end
