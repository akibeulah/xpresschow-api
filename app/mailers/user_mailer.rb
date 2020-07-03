class UserMailer < ApplicationMailer 
    # This class extends the application mailer, so that rails know that this class in charge of
    # managing applications. All views for the methods can be foud it the view directory with 
    # matching names
    
    # Method for generating welcome mail
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Welcome to XpressChow')
    end

    # Method for creating login warning
    def login_warning(user)
        @user = user
        mail(to: @user.email, subject: 'Your account is being accessed')
    end

    # Method for creating password recovery mail
    def forgot_password(user)
        @user = user
        mail(to: @user.email, subject: 'Resetting your XpressChow Password')
    end
end
