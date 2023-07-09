# frozen_string_literal: true

module Profiles
  class CardsController < ApplicationController
    def show
      @profile = Profile.find(params[:id])
      @couples = Couple.includes(:profile1, :profile2)
                       .accessible_by(current_ability)
                       .related_to(params[:id])
      @children = @profile.children_profiles
    end
  end
end
