# frozen_string_literal: true

module UrlTokenizer
  include Rails.application.routes.url_helpers

  ALLOWED_URLS = {
    'profile' => :profile_url
  }.freeze

  def tokenized_url(type, params)
    return unless ALLOWED_URLS.key?(type)

    send(ALLOWED_URLS[type], params.merge(
                               token: jwt_encode(
                                 send(ALLOWED_URLS[type], params.merge(locale: nil))
                               )
                             ))
  end

  def jwt_encode(payload)
    token = JWT.encode({ data: payload }, ENV.fetch('JWT_SECRET') || 'jwt_secret', 'HS256')
    token.sub('.', '-')
  end

  def jwt_decode(token)
    token = token.sub('-', '.')
    decoded_token = JWT.decode token, ENV.fetch('JWT_SECRET') || 'jwt_secret', true, algorithm: 'HS256'
    decoded_token[0]['data']
  end
end
