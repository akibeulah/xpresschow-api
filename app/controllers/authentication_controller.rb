class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login

    def login

        if User.find_by_email(params[:credential])
            @user = User.find_by_email(params[:credential])
        elsif User.find_by_username(params[:credential])
            @user = User.find_by_username(params[:credential])
        else
            return render json: {error: "Username or Email incorrect"}
        end

        if @user&.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: @user.id)
            time = Time.now + 24.hours.to_i
            
            render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username}, status: :ok
        else
            render json: {error: 'unauthorized'}, status: :unauthorized
        end
    end

    private 
    def login_params
        params.permit(:credential, :password)
    end

end
