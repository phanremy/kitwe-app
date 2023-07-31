# frozen_string_literal: true

module Outlines
  class ParentsController < ApplicationController
    include TurboOutline

    authorize_resource class: false

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
      create_parents
      if @errors
        flash.now[:error] = @errors
        render_flash
      else
        @success_message = I18n.t('parents.create_success')
        respond_to do |format|
          format.turbo_stream { family_tree_turbo_response }
        end
      end
    end

    private

    def create_parents
      @parents = []
      ActiveRecord::Base.transaction do
        parents_info.each do |gender, pseudo|
          next unless pseudo.present?

          @parents << Profile.create!(creator_id: current_user.id, gender: gender, pseudo: pseudo)
        end

        create_couples
      end
    rescue StandardError => e
      @errors = e
    end

    def parents_info
      { male: params[:father_pseudo], female: params[:mother_pseudo] }
    end

    def create_couples
      if @parents.count.positive?
        couple = Couple.create!(profile1_id: @parents.first.id, profile2_id: @parents.second&.id, creator_id: current_user.id)
        Profile.find(params[:profile_id]).update!(parents_id: couple.id)
      else
        @errors = I18n.t('parents.at_least_one_parent_error')
      end
    end
  end
end
