ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 465,
    domain: 'xpresschow.herokuapp.co',
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_PASSWORD'],
    authentication: :login,
    enable_starttls_auto: true
}

# ActionMailer::Base.smtp_settings = {
#     domain: 'xpresschow.herokuapp.com',
#     address: "stmp.sendgrid.net",
#     port: 587,
#     authentication: :plain,
#     user_name: 'apikey',
#     enable_starttls_auto: true,
#     password: ENV['SENDGRID_API_KEY']
# }