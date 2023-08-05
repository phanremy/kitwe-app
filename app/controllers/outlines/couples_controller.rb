# frozen_string_literal: true

module Outlines
  class CouplesController < ApplicationController
    include TurboOutline
    load_and_authorize_resource

    def new
      @couple = Couple.new
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :outline,
            partial: 'outlines/couples/form',
            locals: { couple: @couple }
          )
        end
      end
    end

    def create
      @couple = Couple.new(couple_params)
      @couple.profile1_id = params[:profile_id] if params[:profile_id]
      @profile = @couple.profile1
      if @couple.save
        family_tree_turbo_response(success_message: I18n.t('couples.create_success'))
      else
        flash.now[:error] = @couple.errors.full_messages
        render_flash
      end
    end

    def destroy
      @profile = Profile.find(params[:profile_id])
      @couple = Couple.find(params[:id])
      if @couple.destroy
        family_tree_turbo_response(success_message: I18n.t('couples.destroy_success'))
      else
        flash.now[:error] = I18n.t('general_error')
        render_flash
      end
    end

    private

    def couple_params
      params.require(:couple).permit(:profile1_id, :profile2_id, :creator_id)
    end
  end
end
