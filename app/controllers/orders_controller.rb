    class OrdersController < ApplicationController
        before_action :authorize_user, only: [:index, :create, :show] 
        before_action :authorize_vendor, only: [:dispatched]
    
        def index
            @orders = Order.where(user_id: @current_user.id)
            render json: @orders, status: :ok
        end
    
        def show
            @order = @current_user.orders.where(show_params)
            render json: @order, status: :ok
        end
    
        def create
            o = @current_user.orders.build(order_params)
    
            if o.save 
                render json: o, status: :created
            else
                render json: { errors: o.errors.full_messages }, status: :unprocessable_entity
            end
        end
    
        def dispatched
            v = Vendor.find_by(vendorname: params[:_vendorname])
            order = Order.find_by(id: params[:order_id], vendor_id: v.id)
    
            order.order_dispatched!
    
            render json: order, status: :ok
        end
    
        def paid
            v = Vendor.find_by(vendorname: params[:_vendorname])
            order = Order.find_by(id: params[:order_id], vendor_id: v.id)
    
            order.order_paid!
    
            render json: order, status: :ok
        end
    
        def delivered
            v = Vendor.find_by(vendorname: params[:_vendorname])
            order = Order.find_by(id: params[:order_id], vendor_id: v.id)
    
            order.order_delivered!
    
            render json: order, status: :ok
        end
    
        private 
    
        def order_params
            params.permit(:vendor_id, :meal_id, :servings, :location, :payment_method, :paid, :dispatched, :delivered)
        end
    
        def show_params 
            params.permit(:id)
        end
    end
    