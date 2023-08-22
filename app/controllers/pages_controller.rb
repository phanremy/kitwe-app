# frozen_string_literal: true

class PagesController < ApplicationController
  # authorize_resource class: false
  skip_before_action :authenticate_user!
  skip_authorization_check

  def frontpage
    redirect_to profiles_path if user_signed_in?
  end

  def open_modal
    # see filters controller
  end
end
