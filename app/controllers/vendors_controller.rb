    class VendorsController < ApplicationController
        before_action :authorize_vendor, except: [:create, :index, :filtered_vendors, :collection, :show]
        before_action :find_vendor, except: [:create, :index, :filtered_vendors, :collection, :show]
    
        def index
            @vendors = Vendor.left_outer_joins(:meals).group(:id).order('COUNT(meals.id) DESC')
            render json: @vendors, status: :ok
        end

        def collection 
            @vendors ||= Vendor.search_by(params)
            render json: @vendors, status: :ok, each_serializer: VendorCollectionSerializer
        end

        def filtered_vendors         
            @vendors =  Vendor.where(location: params[:location]).left_outer_joins(:meals).group(:id).order('COUNT(meals.id) DESC')
            render json: @vendors, status: :ok
        end
    
        def show
            @vendor = Vendor.find_by(vendorname: params[:vendorname])
            render json: @vendor, status: :ok
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
            @meal = @vendor.meals.build(meal_params)
            @meal.vendor_id = @current_vendor.id
            if @meal.save
                VendorMailer.created_meal(@meal, @current_vendor).deliver_now
                render json: @meal, status: :created
            else
                render json: {errors: @vendor.errors.full_messages}, status: :unprocessable_entity
            end
        end
    
        def destroy
            # @vendor.destroy
        end
    
        def get_orders
            @orders = Order.where(vendor_id: @current_vendor.id)
            render json: @orders, status: :ok
        end
    
        def get_uncompleted
            @orders = Order.where(vendor_id: @current_vendor.id, delivered: false)
            render json: @orders, status: :ok
        end
    
        def get_completed
            @orders = Order.where(vendor_id: @current_vendor.id, delivered: true)
            render json: @orders, status: :ok
        end
    
        private
        def find_vendor
            @vendor = Vendor.find_by_vendorname!(params[:_vendorname])
            rescue ActiveRecord::RecordNotFound
                render json: {errors: 'vendor not found'}, status: :not_found
        end
    
        def vendor_params
            params.permit(:logo, :vendorname, :email, :password, :password_confirmation, :phone_number, :company_name, :company_branch)
        end
    
        def meal_params
            params.permit(:sample, :name, :price, :desc, :sample_alt)
        end
    end
    