# Xpresschow-API

# Code Overview

## Dependecies
- [Jbuilder](https://github.com/rails/jbuilder) - Default JSON rendering gem that ships with Rails, used for making reusable templates for JSON output.
- [JWT](https://github.com/jwt/ruby-jwt) - For generating and validating JWTs for authentication

## Folders

- `app/models` - Contains the database models for the application where we can define methods, validations, queries, and relations to other models.
- `app/views` - Contains templates for generating the JSON output for the API
- `app/controllers` - Contains the controllers where requests are routed to their actions, where we find and manipulate our models and return them for the views to render.
- `config` - Contains configuration files for our Rails application and for our database, along with an `initializers` folder for scripts that get run on boot.
- `db` - Contains the migrations needed to create our database schema.
- `Mailer` - Contains the mailer functions that send details to users and vendors.

## Routes and Endpoints

- `get '/*a'` - Endpoint for not found.

### Public end points
- `get '/meals'` - Lists out all meals

### End points for user management
resources :users, param: :_user_id
- `get '/users/:_user_id` - Returns user profile data
- `post '/users/:_user_id` - Creates a user
- `delete '/users/:_user_id` - Deletes a user
- `post '/user/login` - Authenticates User and generates and returns JWT
- `get '/orders'` - Returns all orders for current user
- `post '/orders'` - Creates and order for the current user
- `get '/orders/:order_id'` - Return a specified order, cannot return order that does not belong to the current user

resources :orders

### End points for vendor managemant
- `get '/vendors` - Returns all vendors profiles
- `get '/vendors/:_vendor_id` - Returns vendor profile data
- `post '/vendors/:_vendor_id` - Creates a vendor
- `delete '/vendors/:_vendor_id` - Deletes a vendor
- `post '/vendor/login` - Authenticates vendor and generates and returns JWT
- `post '/vendor/:_vendorname/meals/new'` - Create meal for the current vendor
- `get 'vendor/:_vendorname/orders'` - Get all orders for the current vendor
- `get 'vendor/:_vendorname/orders/incomplete'` - Get all uncompleted orders for the current vendor
- `get 'vendor/:_vendorname/orders/complete'` - Get all completed orders for the current vendor
- `get 'vendor/:_vendorname/orders/dispatched'` - Sets dispatched on a vendors order to !dispatched
- `get 'vendor/:_vendorname/orders/paid'` - Sets paid on a vendors order to !paid
- `get 'vendor/:_vendorname/orders/delivered'` - Sets delivered on a vendors order to !delivered

### End points for password management
- `post '/password/forgot'` - Initiates the recover password mechanism
- `post '/password/reset'` -  Resets consumers password

