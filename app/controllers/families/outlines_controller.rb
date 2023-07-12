# frozen_string_literal: true

module Families
  class OutlinesController < ApplicationController
    def create
      @profile = Profile.find(params[:id])
      @couples = Couple.includes(:profile1, :profile2)
                       .accessible_by(current_ability)
                       .related_to(params[:id])
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
  end
end
