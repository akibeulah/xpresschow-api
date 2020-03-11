class PasswordsController < ApplicationController
    def forgot
        if params[:emai].blank?
            return render json: {error: 'Please input a valid email address.'}
        else
            user = User.find_by_email(params[:email])
        end

        if user.present?
            user.generate_password_token!
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

        user = User.find_by(reset_password_token: token)

        if user.present? && user.password_token_valid?
            if user.reset_password!(params[:password])
                render json: {status: 'ok'}, status: :ok
            else
                render json: {error: user.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {error: 'Link not valid or expired.'}, status: :not_found
        end
    end
end
