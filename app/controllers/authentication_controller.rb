class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login

    def login

        if User.find_by_email(params[:credential])
            @user = User.find_by_email(params[:credential])
        elsif User.find_by_username(params[:credential])
            @user = User.find_by_username(params[:credential])
        elsif Vendor.find_by_email(params[:credential])
            @vendor = Vendor.find_by_email(params[:credential])
        elsif Vendor.find_by_vendorname(params[:credential])
            @vendor = Vendor.find_by_vendorname(params[:credential])
        else
            return render json: {error: "Username or Email incorrect"}
        end

        if @user&.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: @user.id)
            time = Time.now + 24.hours.to_i
            
            UserMailer.login_warning(@user).deliver_now
            render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username}, status: :ok
        elsif @vendor&.authenticate(params[:password])
            token = JsonWebToken.encode(vendor_id: @vendor.id)
            time = Time.now + 24.hours.to_i
            
            VendorMailer.login_warning(@vendor).deliver_now
            render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), vendorname: @vendor.vendorname}, status: :ok
        else
            render json: {error: 'unauthorized'}, status: :unauthorized
        end
    end

    private 
    def login_params
        params.permit(:credential, :password)
    end

end
