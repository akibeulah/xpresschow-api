module Api # This is a namespace, it helps specify that this is an Api
    module V1 # Another namespace that specifies that this is the first version of the application
        class UsersController < Api::V1::BaseController 
            # Notice that this controller inherits from the base controller instaed of the application controller directly,
            # this is to help with versioning. If a function gets deprecated in the application controller, but is still needed
            # in the first version of the application, it will be moved to the Api::V1::BaseController file, which is the Api/v1
            # directory. That way the function won't clash with the new function but will still be available the v1 controllers

            # before_action are methods that are run to check the validity of a request before the request is allowed access to the
            # controller. The before_actions below run for all methods in this controller except for the ones specified in the except 
            # clause.
            before_action :authorize_user, except: [:create, :collection] 
            # This method checks if the user is using a valid JWT token. :authorize_user is defined in the application controller.
            before_action :find_user, except: %i[create collection]
            # This method makes sure the user data being returned matches the user in the JWT token. :find_user is defined at the bottom of the user controller.
        
            # def index
            #     users = User.all
            #     render json: users, status: :ok
            # end
        
            # This method returns the data stored about the user in the data base, it uses the UserSerializer by default, since the model 
            # the serializer have the same name.
            def show
                if @current_user.id == params[:id].to_i
                    render json: @current_user, status: :ok
                else
                    render json: "Invalid", status: :unauthorized
                end
            end
    
            # This method is used to search the database for Vendors and Meals. It returns the vendors and meals that match the query being
            # passed in. To check the data that the vendors and meals are being queried against, you'll need to look at their respective models. 
            def collection 
                @vendors ||= Vendor.search_vendors(params[:query])
                @meals ||= Meal.search_meals(params[:query])
                
                render json: { vendors: @vendors, meals: @meals, status: :ok }
            end

            # Recieves new user location and updates it with the update_location! method which is defined in the user model.
            def location
                user.update_location!(params[:location])
            end
        
            # This method creates a user in the database with the sanitized parameters provided
            def create
                user = User.new(user_params)
                if user.save
                    render json: {status: :created}
                    UserMailer.welcome_email(user).deliver_now 
                    # Sends out a welcome email to the user upon account creation. The view for the email can be found in the views directory, but the
                    # welcome_email function definition is in the mailer directory in the UserMailer file.
                else
                    render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
                end
            end

            # Destroys a user entry in the database, effectively terminating an account.        
            def destroy
                user.destroy
            end
        
            private # Protected methods are defined under private, this also makes sure they are not tempared with from another controller
                def find_user # This function ensures that the user data being used for queries matches the user from the authorized token
                    user = User.find_by_id!(params[:id])
                    rescue ActiveRecord::RecordNotFound
                        render json: {errors: 'User not found'}, status: :not_found
                end
                
                # This method the sanitizes parameters used for user creation. 
                def user_params
                    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
                end
        end
    end
end