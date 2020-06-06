class UserMailer < ApplicationMailer
    
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Welcome to XpressChow')
    end

    def login_warning(user)
        @user = user
        mail(to: @user.email, subject: 'Your account is being accessed')
    end

    def forgot_password(user)
        @user = user
        mail(to: @user.email, subject: 'Resetting your XpressChow Password')
    end
end
