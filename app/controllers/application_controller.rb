class ApplicationController < ActionController::API

  def authenticate_user!
    render json: { error: 'Authorization key not found or Incorrect' }, status: :unauthorized unless current_user
  end

  def current_user
    @current_user ||= decode_jwt_token
  end

  def authorize_admin!

    return if current_user && current_user.admin?
  
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: exception.message }, status: :not_found
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception.message }, status: :bad_request
  end

  def not_found
    render json: { error: 'Route not found. Please check URL' }, status: :not_found
  end

  private

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
