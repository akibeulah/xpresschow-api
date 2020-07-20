module Api
    module V1
        class OrdersController < Api::V1::BaseController
            require 'json'
    
            before_action :authorize_user, only: [:index, :create, :show] 
            before_action :authorize_vendor, only: [:dispatched]
        
            def index
                orders = Order.where(user_id: @current_user.id)
                render json: orders, status: :ok
            end
        
            def show
                order = Orders.find(show_params)
                if @current_user.id == order.user
                    render json: order, status: :ok
                else
                    render status: :unauthorized
                end
            end
        
            def create
                orders = JSON.parse(params[:orders].to_s)
                order = Order.new(
                    vendor_id: params[:vendor_id],
                    user_id: @current_user.id,
                    address: params[:address],
                    location: params[:location],
                    payment_method: params[:payment_method],
                    paid: params[:paid],
                    price: params[:price]
                )
                    
                if order.save 
                    orders.each do |o| 
                        OrderRecord.create(
                            meal_id: (o[0].to_i),
                            servings: (o[2].to_i),
                            order_id: order.id
                        )
                    end
                    render json: order, status: :created
                else
                    render json: {errors: order.errors.full_messages}, status: :unprocessable_entity
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
                params.permit(:vendor_id, :user_id, :address, :location, :payment_method, :price, :paid, :orders)
            end
        
            def show_params 
                params.permit(:id)
            end
        end
        
    end
end