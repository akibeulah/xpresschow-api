module Api
    module V1
        class VendorsController < Api::V1::BaseController
            before_action :authorize_vendor, except: [:create, :index, :filtered_vendors, :show]
            before_action :find_vendor, except: [:create, :index, :filtered_vendors, :show]

            def index
                # Todo: Pagination for vendor show...
                @vendors = Vendor.left_outer_joins(:meals).group(:id).order('COUNT(meals.id) DESC')
                render json: @vendors, status: :ok
            end

            def update
                if @vendor.update!(updated_vendor_params)
                        render json: @vendor, status: :ok
                    else
                        render json: {errors: @meal.errors.full_messages}, status: :unprocessable_entity
                    end
            end
    
            def filtered_vendors         
                @vendors =  Vendor.where(location: params[:location]).left_outer_joins(:meals).group(:id).order('COUNT(meals.id) DESC')
                # @vendors =  Vendor.all
                render json: @vendors, status: :ok
            end
        
            def show
                @vendor = Vendor.find_by(vendorname: params[:vendorname])
                render json: @vendor, status: :ok
            end

            def profile
                @vendor = Vendor.find_by(vendorname: params[:vendorname])
                render json: @vendor,serializer: VendorProfileSerializer, status: :ok
            end
        
            def create
                @vendor = Vendor.new(vendor_params)
                if @vendor.save 
                    render json: @vendor, status: :created
                    VendorMailer.welcome_email(@vendor).deliver_now
                else
                    render json: {errors: @vendor.errors.full_messages}, status: :unprocessable_entity
                end
            end
        
            def create_meal
                @meal = Meal.new(
                    vendor_id: @vendor.id,
                    name: params[:name],
                    sample: params[:sample],
                    desc: params[:desc],
                    sample_alt: params[:sample_alt],
                    discount: params[:discount],
                    price: params[:price],
                    tag: params[:tag]
                )
                if @meal.save!
                    VendorMailer.created_meal(@meal, @current_vendor).deliver_now
                    render json: @meal, status: :created
                else
                    render json: {errors: @vendor.errors.full_messages}, status: :unprocessable_entity
                end
            end
            
            def edit_meal 
                # @vendor = Vendor.find(vendorname: params[:vendorname])
                @meal = Meal.find(params[:id])

                # if @meal.vendor = @vendor 
                    if @meal.update!(updated_meal_params)
                        render json: @meal, status: :ok
                    else
                        render json: {errors: @meal.errors.full_messages}, status: :unprocessable_entity
                    end
                # else
                    # render json: {errors: "Meal association error"}, status: :unauthorized
                # end
            end
            
            def toggle_meal 
                if Vendor.find_by(vendorname: params[:vendorname]) == @current_vendor
                    @meal = Meal.find(params[:id])
                if @meal.toggle!(:available)
                    render json: @meal.vendor, status: :ok, serializer: VendorProfileSerializer
                else
                    render json: { errors: @meal.error.full_messages}, status: :unprocessable_entity
                end
            else
                render json: { errors: @meal.error.full_messages}, status: :unprocessable_entity
            end
            end
            
            def toggle_prepared
                @order = Order.find_by(id: params[:id])
                if @order.toggle!(:prepared)
                    render json: Order.where(vendor_id: @current_vendor.id), status: :ok, each_serializer: OrderSerializer
                else
                    render json: { errors: @order.error.full_messages}, status: :unprocessable_entity
                end
            end

            def destroy
                @vendor.destroy
            end

            def destroy_meal
                del = @current_user.meals.where(id: params[:id]).destroy
                puts del.errors.full_messages
            end
        
            def get_orders
                @orders = Order.where(vendor_id: @current_vendor.id)
                render json: @orders, status: :ok, each_serializer: OrderSerializer
            end
        
            private
            def find_vendor
                @vendor = Vendor.find_by_vendorname!(params[:vendorname])
                rescue ActiveRecord::RecordNotFound
                    render json: {errors: 'vendor not found'}, status: :not_found
            end
        
            def vendor_params
                params.permit(:logo, :vendorname, :email, :password, :password_confirmation, :phone_number, :company_name, :company_branch, :address, :location)
            end
            
            def updated_vendor_params
                params.permit(:logo, :vendorname, :email, :password, :password_confirmation, :phone_number, :company_name, :company_branch, :address, :location)
            end
        
            def meal_params
                params.permit(:vendorname, :sample, :name, :price, :desc, :sample_alt, :discount, :tag)
            end
            
            def updated_meal_params
                params.permit(:id, :name, :sample, :price, :desc, :sample_alt, :discount, :tag, :available)
            end
        end
        
    end
end