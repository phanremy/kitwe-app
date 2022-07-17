# frozen_string_literal: true

class PagesController < ApplicationController
  # authorize_resource class: false
  skip_before_action :authenticate_user!
  skip_authorization_check

  def open_modal
    render turbo_stream: turbo_stream.append(
      :main,
      partial: 'shared/modal',
      locals: { content: 'here is a modal' }
    )
  end
end
