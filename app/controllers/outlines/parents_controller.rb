# frozen_string_literal: true

module Outlines
  class ParentsController < ApplicationController
    authorize_resource class: false
    before_action :create_parents, only: :create

    def new
      @profile = Profile.find(params[:profile_id])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'outlines/parents/form',
            locals: { profile: @profile }
          )
        end
      end
    end

    def create
      if @errors
        flash.now[:error] = @errors
        render_flash
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update(:outline, '')
          end
        end
      end
    end

    private

    def create_parents
      ActiveRecord::Base.transaction do
        @profile = Profile.find(params[:profile_id])
        profile1 = Profile.create!(creator_id: current_user.id, gender: 'male', pseudo: params[:father_pseudo])
        profile2 = Profile.create!(creator_id: current_user.id, gender: 'female', pseudo: params[:mother_pseudo])
        couple = Couple.create!(profile1_id: profile1.id, profile2_id: profile2.id, creator_id: current_user.id)
        @profile.update!(parents_id: couple.id)
      end
    rescue StandardError => e
      @errors = e
    end
  end
end
