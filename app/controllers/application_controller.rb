class ApplicationController < ActionController::API
        def authorize_user
            header = request.headers['Authorization']
            header = header.split(' ').last if header
            
            begin
                @decoded = JsonWebToken.decode(header)
                @current_user = User.find(@decoded[:user_id])
                    
            rescue ActiveRecord::RecordNotFound => e
                render json: {errors: e.message}, status: :unauthorized
            rescue JWT::DecodeError => e
                render json: {errors: e.message}, status: :unauthorized
            end
        end
    
        def authorize_vendor
            header = request.headers['Authorization']
            header = header.split(' ').last if header
    
            begin
                @decoded = JsonWebToken.decode(header)
                @current_vendor = Vendor.find(@decoded[:vendor_id])
                
            rescue ActiveRecord::RecordNotFound => e
                puts  e.message
                render json: {errors: e.message}, status: :unauthorized
            rescue JWT::DecodeError => e
                puts  e.message
                render json: {errors: e.message}, status: :unauthorized
            end
        end
    
        def authorize_carrier
            header = request.headers['Authorization']
            header = header.split(' ').last if header
    
            begin
                @decoded = JsonWebToken.decode(header)
                @current_carrier = Carrier.find(@decoded[:carrier_id])
                
            rescue ActiveRecord::RecordNotFound => e
                puts  e.message
                render json: {errors: e.message}, status: :unauthorized
            rescue JWT::DecodeError => e
                puts  e.message
                render json: {errors: e.message}, status: :unauthorized
            end
        end

            def not_found
                render json: {error: 'not found'}
            end
    end