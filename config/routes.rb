  Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"

  namespace :api do
    namespace :v1 do
       # Public end points
       get '/meals', to: 'meals#index'
  
       # End points for user management
       resources :users do
         collection { post :create, via: :options  }
       end
       post '/user/login', to: 'authentication#login_user'
       post '/update_location', to: 'users#location'
       get '/search', to: 'users#collection'
       
       resources :orders
       
       resources :carriers, param: :carriername
       post '/carrier/login', to: 'authentication#login_carrier'
       get '/carrier/dashboard', to: 'carriers#dashboard'
       get '/carrier/jobs', to: 'carriers#jobs'
       post '/carrier/register_job', to: 'carriers#register_job'
       post '/carrier/toggle_delivered', to: 'carriers#toggle_delivered'
       
       # End points for vendor managemant
       resources :vendors, param: :vendorname
       post '/vendor/login', to: 'authentication#login_vendor'
       get '/f_vendor', to: 'vendors#filtered_vendors'
       get ':vendorname/profile', to: 'vendors#profile'
       post '/vendor/:vendorname/meals/new', to: 'vendors#create_meal'
       patch '/vendor/:vendorname/meals/update', to: 'vendors#edit_meal'
       patch '/vendor/:vendorname/meals/toggle', to: 'vendors#toggle_meal'
       delete '/vendor/:vendorname/meals/destroy', to: 'vendors#destroy_meal'
       patch '/vendor/:vendorname/orders/dispatch', to: 'vendors#toggle_dispatch'
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