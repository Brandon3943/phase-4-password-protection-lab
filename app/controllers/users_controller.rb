class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = user.id
          render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(session[:user_id])
        render json: user, status: :ok
    end



    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

    def record_not_found user
        render json: {error: "#{user.model} - please log in"}, status: :unauthorized 
    end


end
