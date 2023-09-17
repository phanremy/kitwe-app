# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  NARROW_NON_BREAKING_SPACE = 8239

  def frontpage?
    params[:controller] == 'pages' && params[:action] == 'frontpage'
  end

  def non_breaking(string)
    string.sub(' ', [NARROW_NON_BREAKING_SPACE].pack('U*'))
  end

  def switch_language
    switch_locale == :fr ? 'Français' : 'English'
  end

  def switch_locale
    params[:locale]&.to_sym == :fr ? :en : :fr
  end

  def switch_locale_path
    url_for(locale: switch_locale, token: params[:token])
  end
end
