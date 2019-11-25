class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      head :ok
    else
      render json: user.errors.to_json, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :public_key)
  end
end
