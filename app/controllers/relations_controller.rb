# frozen_string_literal: true

class RelationsController < ApplicationController
  authorize_resource class: false

  def index
    @profile1_id = params[:profile1_id]
    @profile2_id = params[:profile2_id]
    @content = if [@profile1_id, @profile2_id].any?(&:blank?)
                 I18n.t('relations.missing_input')
               else
                #  Relation.find_relation(@profile1_id, @profile2_id)
               end
  end
end
