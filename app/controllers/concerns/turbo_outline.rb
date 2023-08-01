# frozen_string_literal: true

module TurboOutline
  extend ActiveSupport::Concern

  def family_tree_turbo_response(success_message: '')
    flash[:success] = success_message
    @data = Profiles::FamilyTreeCreator.new(@profile.id).call
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream_data
      end
    end
  end

  private

  def turbo_stream_data
    [
      turbo_stream.update(:outline, ''),
      turbo_stream.update(:flash, partial: 'shared/flash'),
      turbo_stream.update(
        :tree,
        partial: 'shared/tree',
        locals: { id: @profile.id, data: @data.to_json }
      )
    ]
  end
end
