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
      profiles = []
      ActiveRecord::Base.transaction do
        profiles << Profile.create!(creator_id: current_user.id, gender: 'male', pseudo: params[:father_pseudo]) if params[:father_pseudo].present?
        profiles << Profile.create!(creator_id: current_user.id, gender: 'female', pseudo: params[:mother_pseudo]) if params[:mother_pseudo].present?
        create_couples(profiles)
      end
    rescue StandardError => e
      @errors = e
    end

    def create_couples(profiles)
      if profiles.count.positive?
        couple = Couple.create!(profile1_id: profiles.first.id, profile2_id: profiles.second&.id, creator_id: current_user.id)
        Profile.find(params[:profile_id]).update!(parents_id: couple.id)
      else
        @errors = 'At least one parent nickname is required'
      end
    end
  end
end
