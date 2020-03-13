Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    default_url_options :host => "https://xpresschow.herokuapp.com"

    # End points for user management
    resources :users, param: :_username
    post '/user/login', to: 'authentication#login_user'

    # End points for vendor managemant
    resources :vendors, param: :_vendorname
    post '/vendor/login', to: 'authentication#login_vendor'
    post '/vendor/:_vendorname/meals/new', to: 'vendors#create_meal'

    # End points for password management
    # Todo: intensify vendor account creation
    post '/password/forgot', to: 'passwords#forgot'
    post '/password/reset', to: 'passwords#reset'

    get '/*a', to: 'application#not_found'
  end
end
