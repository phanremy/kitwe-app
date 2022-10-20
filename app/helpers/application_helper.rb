# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  NARROW_NON_BREAKING_SPACE = 8239

  def non_breaking(string)
    string.sub(' ', [NARROW_NON_BREAKING_SPACE].pack('U*'))
  end
end
