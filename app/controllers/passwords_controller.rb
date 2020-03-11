class PasswordsController < ApplicationController
    def forgot
        if params[:email].blank?
            return render json: {error: 'Please input a valid email address.'}
        else
            if User.find_by_email(params[:email])
                user = User.find_by_email(params[:email])
            else
                vendor = Vendor.find_by_email(params[:email])
            end
        end

        if user.present?
            user.generate_password_token!
            UserMailer.forgot_password(user).deliver_now

            render json: {status: 'ok'}, status: :ok
        elsif vendor.present?
            vendor.generate_password_token!
            VendorMailer.forgot_password(user).deliver_now

            render json: {status: 'ok'}, status: :ok
        else
            render json: {error: ['Email address not found.']}, status: :ok
        end
    end

    def reset
        token = params[:token].to_s

        if params[:email].blank?
            return render json: {error: 'Token not present.'}
        end

        if User.find_by(reset_password_token: token)
            user = User.find_by(reset_password_token: token)
        else
            vendor = Vendor.find_by(reset_password_token: token)
        end

        if user.present? && user.password_token_valid?
            if user.reset_password!(params[:password])
                render json: {status: 'ok'}, status: :ok
            else
                render json: {error: user.errors.full_messages}, status: :unprocessable_entity
            end
        elsif vendor.present? && vendor.password_token_valid?
            if vendor.reset_password!(params[:password])
                render json: {status: 'ok'}, status: :ok
            else
                render json: {error: vendor.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {error: 'Link not valid or expired.'}, status: :not_found
        end
    end
end
