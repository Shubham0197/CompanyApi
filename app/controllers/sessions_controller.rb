class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, 'SECRET_KEY_BASE')
      render json: { token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
