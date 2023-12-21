class ApplicationController < ActionController::API

  def authenticate_user!
    head :unauthorized unless current_user
  end

  def current_user
    @current_user ||= decode_jwt_token
  end

  def decode_jwt_token
    token = request.headers['Authorization']&.split&.last
    return unless token

    begin
      # Assuming you are using the 'jwt' gem
      payload = JWT.decode(token, 'SECRET_KEY_BASE', true).first
      User.find(payload['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      nil
    end
  end

end
