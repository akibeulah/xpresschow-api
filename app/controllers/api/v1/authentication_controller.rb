module Api
    module V1
        class AuthenticationController < Api::V1::BaseController        
            def login_user
                if User.find_by_email(params[:credential])
                    @user = User.find_by_email(params[:credential])
                else
                    return render json: {error: "Email does not exist"}, status: :unauthorized
                end
        
                if @user&.authenticate(params[:password])
                    token = JsonWebToken.encode(user_id: @user.id)
                    time = Time.now + 24.hours.to_i
                    
                    # UserMailer.login_warning(@user).deliver_now
                    render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user, consumer: 'user'}, status: :ok
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
                     render json: {error: "Vendorname or Email Incorrect"}
                end
        
                if @vendor&.authenticate(params[:password])
                    token = JsonWebToken.encode(vendor_id: @vendor.id)
                    time = Time.now + 24.hours.to_i
                    
                    render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), vendor: @vendor, consumer: 'vendor'}, status: :ok
                    VendorMailer.login_warning(@vendor).deliver_now
                else
                    render json: {error: 'unauthorized'}, status: :unauthorized
                end
            end
            
            def login_carrier
                if Carrier.find_by_email(params[:credential])
                    @carrier = Carrier.find_by_email(params[:credential])
                elsif Carrier.find_by_carriername(params[:credential])
                    @carrier = Carrier.find_by_carriername(params[:credential])
                else
                     render json: {error: "Carriername or Email Incorrect"}
                end
        
                if @carrier&.authenticate(params[:password])
                    token = JsonWebToken.encode(carrier_id: @carrier.id)
                    time = Time.now + 24.hours.to_i
                    
                    # CarrierMailer.login_warning(@carrier).deliver_now
                    render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), carrier: @carrier, consumer: 'carrier'}, status: :ok
                else
                    render json: {error: 'unauthorized'}, status: :unauthorized
                end
            end
        
            private 
            def login_params
                params.permit(:credential, :password)
            end
        
        end    
    end
end