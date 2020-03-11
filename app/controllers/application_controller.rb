class ApplicationController < ActionController::API
    def not_found
        render json: {error: 'not found'}
    end

    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header

        begin
            @decoded = JsonWebToken.decode(header)
            if User.find(@decoded[:user_id])
                @current_user = User.find(@decoded[:user_id])
            elsif Vendor.find(@decoded[:vendor_id])
                @current_vendor = Vendor.find(@decoded[:vendor_id])
            end

        rescue ActiveRecord::RecordNotFound => e
            render json: {errors: e.message}, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: {errors: e.message}, status: :unauthorized
        end
    end
end

