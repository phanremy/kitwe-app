# frozen_string_literal: true

module TurboOutline
  extend ActiveSupport::Concern

  def family_tree_turbo_response
    flash[:success] = @success_message
    turbo_stream_data = [
      turbo_stream.update(:outline, ''),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]
    render turbo_stream: turbo_stream_data
  end
end
