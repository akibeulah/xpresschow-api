  Rails.application.routes.draw do
  default_url_options :host => "localhost:3001"

      # Public end points
      get '/meals', to: 'meals#index'
  
      # End points for user management
      resources :users, param: :_user_id do
        collection { post :create, via: :options  }
      end
      post '/user/login', to: 'authentication#login_user'
      post '/auto', to: 'authentication#auto_login'
      post '/update_location', to: 'users#location'
      resources :orders
  
      # End points for vendor managemant
      resources :vendors, param: :_vendorname
      get '/f_vendor', to: 'vendors#filtered_vendors'
      post '/vendor/login', to: 'authentication#login_vendor'
      post '/vendor/:_vendorname/meals/new', to: 'vendors#create_meal'
      get 'vendor/:_vendorname/orders', to: 'vendors#get_orders'
      get 'vendor/:_vendorname/orders/dispatched', to: 'orders#dispatched'
      get 'vendor/:_vendorname/orders/paid', to: 'orders#paid'
      get 'vendor/:_vendorname/orders/delivered', to: 'orders#delivered'
      get 'vendor/:_vendorname/orders/incomplete', to: 'vendors#get_uncompleted'
      get 'vendor/:_vendorname/orders/complete', to: 'vendors#get_completed'
  
      # End points for password management
      # Todo: intensify vendor account creation
      post '/password/forgot', to: 'passwords#forgot'
      post '/password/reset', to: 'passwords#reset'
  
      get '/*a', to: 'application#not_found'
  
      get '*path', to: redirect('/'), constraints: lambda { |req|
        req.path.exclude? 'rails/active_storage'
      }
end