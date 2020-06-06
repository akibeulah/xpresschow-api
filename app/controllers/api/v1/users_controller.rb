module Api::V1
    class UsersController < ApplicationController
        before_action :authorize_user, except: [:create, :index]
        before_action :find_user, except: %i[create index]
    
        # def index
        #     @users = User.all
        #     render json: @users, status: :ok
        # end
    
        def show
            render json: @user, status: :ok
        end
    
        def create
            @user = User.new(user_params)
        if @user.save
                render json: @user, status: :created
                UserMailer.welcome_email(@user).deliver_now
            else
                render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
            end
        end
    
        def destroy
            @user.destroy
        end
    
        private
        def find_user
            @user = User.find_by_id!(params[:_user_id])
            rescue ActiveRecord::RecordNotFound
                render json: {errors: 'User not found'}, status: :not_found
        end
    
        def user_params
            params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
        end
    end
    
end