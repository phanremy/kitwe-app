# frozen_string_literal: true

module Families
  class OutlinesController < ApplicationController
    include Tokenizer

    skip_before_action :authenticate_user!, only: %i[create]
    before_action :validate_url_token, only: %i[create]
    authorize_resource class: false

    def create
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :modal,
            partial: 'families/outline',
            locals: locals
          )
        end
      end
    end

    private

    def locals
      # TODO: check if outline_id and profile_id are related
      @profile = Profile.find(params[:outline_id])
      check_valid_outline

      @couples = Couple.includes(:profile1, :profile2).related_to(params[:outline_id])
      @children = @profile.children_profiles
      { profile: @profile, couples: @couples, children: @children }
    end

    def check_valid_outline
      main_profile = Profile.find(params[:id])
      return if @profile.creator == main_profile.creator

      raise "Hacking Tree Outline! from Profile ##{params[:id]} " \
            "from creator #{main_profile.creator.email} hacker: #{current_user&.email}, " \
            "trying to access ##{@profile.id} #{@profile.designation}"
    end

    def current_ability
      @current_ability ||= ::Ability.new(current_user, params[:token])
    end
  end
end
