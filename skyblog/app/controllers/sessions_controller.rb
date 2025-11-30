class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
  
      if user&.authenticate(params[:password])
        render json: { token: user.auth_token }
      else
        render json: { error: "Invalid Credentials" }, status: :unauthorized
      end
    end
end
  