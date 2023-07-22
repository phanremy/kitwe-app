# frozen_string_literal: true

module Families
  class OutlinesController < ApplicationController
    include Tokenizer

    skip_before_action :authenticate_user!, only: %i[create]
    before_action :validate_url_token, only: %i[create]
    authorize_resource class: false

    def create
      @profile = Profile.find(params[:outline_id])
      @couples = Couple.includes(:profile1, :profile2)
                       .accessible_by(current_ability)
                       .related_to(params[:outline_id])
      @children = @profile.children_profiles
      locals = {
        profile: @profile,
        couples: @couples,
        children: @children
      }
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'profiles/outline',
            locals: locals
          )
        end
      end
    end

    private

    def current_ability
      @current_ability ||= ::Ability.new(current_user, params[:token])
    end
  end
end
