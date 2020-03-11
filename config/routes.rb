Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    get '/*a', to: 'application#not_found'

    # End points for user management
    resources :users, param: :_username
  resources :vendors, param: :_vendorname
    post '/auth/login', to: 'authentication#login'
    post '/password/forgot', to: 'passwords#forgot'
    post '/password/reset', to: 'passwords#reset'
  end
end
