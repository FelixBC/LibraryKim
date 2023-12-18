# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      # Successful login
      render json: { message: 'Login successful' }, status: :ok
    else
      # Failed login
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end
end

