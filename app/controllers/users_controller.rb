    class UsersController < ApplicationController
        before_action :authorize_user, except: [:create, :index]
        before_action :find_user, except: %i[create index get_vendor_name]
    
        # def index
        #     users = User.all
        #     render json: users, status: :ok
        # end
    
        def show
            if @current_user.id == params[:id].to_i
                render json: @current_user, status: :ok
            else
                render json: "Invalid", status: :unauthorized
            end
        end

        def location
            user.update_location!(params[:location])
        end
    
        def create
            user = User.new(user_params)
        if user.save
                render json: {status: :created}
                UserMailer.welcome_email(@user).deliver_now
            else
                render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
            end
        end
    
        def destroy
            user.destroy
        end
    
        private
        def find_user
            user = User.find_by_id!(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: {errors: 'User not found'}, status: :not_found
        end
    
        def user_params
            params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
        end

        def vendor_name
            params.permit(:vendor_id)
        end
    end