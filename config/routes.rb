Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    default_url_options :host => "localhost:3001"

    # Public end points
    get '/meals', to: 'meals#index'

    # End points for user management
    resources :users, param: :_user_id
    post '/user/login', to: 'authentication#login_user'
    resources :orders

    # End points for vendor managemant
    resources :vendors, param: :_vendorname
    post '/vendor/login', to: 'authentication#login_vendor'
    post '/vendor/:_vendorname/meals/new', to: 'vendors#create_meal'

    # End points for password management
    # Todo: intensify vendor account creation
    post '/password/forgot', to: 'passwords#forgot'
    post '/password/reset', to: 'passwords#reset'

    get '/*a', to: 'application#not_found'

    get '*path', to: redirect('/'), constraints: lambda { |req|
      req.path.exclude? 'rails/active_storage'
    }
  end
end
