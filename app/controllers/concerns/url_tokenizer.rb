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

  def validate_token
    return unless params[:token].present?
    return if valid_token?

    raise "Invalid token"
  rescue StandardError => _e
    respond_to do |format|
      format.html { redirect_to root_path, flash: { danger: 'Access denied.' } }
    end
  end

  def valid_token?
    return false unless params[:token]

    decoded_url = jwt_decode(params[:token])
    allowed_urls.include?(decoded_url) ||
      jwt_decode(params[:token])['id'].to_s == profile_id
  end

  private

  def jwt_encode(payload)
    token = JWT.encode({ data: payload }, jwt_secret, 'HS256')
    token.sub('.', '-')
  end

  def jwt_decode(token)
    token = token.sub('-', '.')
    decoded_token = JWT.decode token, jwt_secret, true, algorithm: 'HS256'
    decoded_token[0]['data']
  end

  def jwt_secret
    ENV.fetch('JWT_SECRET', nil) || 'jwt_secret'
  end

  def allowed_urls
    [
      profile_url(profile_id, profile_id: nil),
      profile_url(profile_id)
    ].compact
  end

  def profile_id
    params[:id] || params[:profile_id]
  end
end
