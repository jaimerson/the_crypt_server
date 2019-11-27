class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: { username: user.username }, status: :ok
    else
      render json: { errors: user.errors.to_json }, status: :unprocessable_entity
    end
  end

  def authenticate
    user = User.find_by(username: user_params[:username])
    if user&.authenticate(user_params[:password])
      # Eventually this should return a JSON token for subsequent requests, but ain't nobody got time for that
      render json: { username: user.username, public_key: user.public_key }, status: :ok
    else
      render json: { errors: 'Invalid credentials' }, status: :forbidden
    end
  end

  def show
    user = User.find_by(username: params[:username])
    if user
      render json: { username: user.username, public_key: user.public_key }, status: :ok
    else
      head :not_found
    end
  end

  def update_token
    user = User.find_by!(params[:username])
    if user.update(firebase_token: user_params[:firebase_token])
      head :ok
    else
      render json: { errors: user.errors.to_json }
    end
  end

  private

  def user_params
    params.permit(:username, :password, :public_key, :firebase_token)
  end
end
