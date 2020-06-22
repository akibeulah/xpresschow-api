  Rails.application.routes.draw do
  default_url_options :host => "localhost:3001"

  namespace :api do
    namespace :v1 do
       # Public end points
       get '/meals', to: 'meals#index'
  
       # End points for user management
       resources :users do
         collection { post :create, via: :options  }
       end
       post '/user/login', to: 'authentication#login_user'
       post '/auto', to: 'authentication#auto_login'
       post '/update_location', to: 'users#location'
       resources :orders
   
       # End points for vendor managemant
       resources :vendors, param: :vendorname
       get '/f_vendor', to: 'vendors#filtered_vendors'
       get '/v_search', to: 'vendors#collection'
       post '/vendor/login', to: 'authentication#login_vendor'
       post '/vendor/:vendorname/meals/new', to: 'vendors#create_meal'
       get 'vendor/:vendorname/orders', to: 'vendors#get_orders'
       get 'vendor/:vendorname/orders/dispatched', to: 'orders#dispatched'
       get 'vendor/:vendorname/orders/paid', to: 'orders#paid'
       get 'vendor/:vendorname/orders/delivered', to: 'orders#delivered'
       get 'vendor/:vendorname/orders/incomplete', to: 'vendors#get_uncompleted'
       get 'vendor/:vendorname/orders/complete', to: 'vendors#get_completed'
   
       # End points for password management
       # Todo: intensify vendor account creation
       post '/password/forgot', to: 'passwords#forgot'
       post '/password/reset', to: 'passwords#reset'
    end
  end

    get '/*a', to: 'application#not_found'

    # get '*path', to: redirect('/'), constraints: lambda { |req|
    #   req.path.exclude? 'rails/active_storage'
    # }
end