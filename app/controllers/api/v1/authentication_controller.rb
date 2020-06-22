module Api
    module V1
        class AuthenticationController < Api::V1::BaseController
            before_action :authorize_request, except: [:login_user, :login_vendor]
        
            def login_user
                if User.find_by_email(params[:credential])
                    @user = User.find_by_email(params[:credential])
                else
                    return render json: {error: "Email Incorrect"}, status: :unprocessable_entity
                end
        
                if @user&.authenticate(params[:password])
                    token = JsonWebToken.encode(user_id: @user.id, class: 'user')
                    time = Time.now + 24.hours.to_i
                    
                    # UserMailer.login_warning(@user).deliver_now
                    render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user}, status: :ok
                else
                    render json: {error: 'Email or Password Incorrect'}, status: :unprocessable_entity
                end
            end
        
            def login_vendor
                if Vendor.find_by_email(params[:credential])
                    @vendor = Vendor.find_by_email(params[:credential])
                elsif Vendor.find_by_vendorname(params[:credential])
                    @vendor = Vendor.find_by_vendorname(params[:credential])
                else
                    return render json: {error: "Vendorname or Email Incorrect"}
                end
        
                if @vendor&.authenticate(params[:password])
                    token = JsonWebToken.encode(vendor_id: @vendor.id)
                    time = Time.now + 24.hours.to_i
                    
                    VendorMailer.login_warning(@vendor).deliver_now
                    render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), vendorname: @vendor.vendorname}, status: :ok
                else
                    render json: {error: 'unauthorized'}, status: :unauthorized
                end
            end

            def auto_login
                if session_user
                    render json: session_user
                else
                    render json: {errors: "No User Logged In"}
                end
            end
        
            private 
            def login_params
                params.permit(:credential, :password)
            end
        
        end    
    end
end