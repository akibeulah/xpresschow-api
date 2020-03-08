class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user, except: %i[create index]

    def index
        @users = User.all
        render json: @users, status: :ok
    end

    def show
        user_serializer = UserSerializer.new(user: @user)
        render json: user_serializer.serialize_new_user(), status: :ok
    end

    def create
        @user = User.new(user_params)
        if @user.save 
            render json: @user, status: :created
        else
            render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
    end

    private
    def find_user
        @user = User.find_by_username!(params[:_username])
        rescue ActiveRecord::RecordNotFound
            render json: {errors: 'User not found'}, status: :not_found
    end

    def user_params
        params.permit(:avatar, :first_name, :middle_name, :last_name, :username, :email, :password, :password_confirmation)
    end
end
