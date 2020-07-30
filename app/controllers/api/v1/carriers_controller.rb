module Api
  module V1
    class CarriersController< ApplicationController
      before_action :authorize_carrier, except: [:create] 

      def create
        carrier = Carrier.new(carrier_params)
        if carrier.save
            render json: {status: :created}
            # CarrierMailer.welcome_email(@carrier).deliver_now 
        else
          puts  carrier.errors.full_messages
            render json: {errors: carrier.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
          render json: @current_carrier, status: :ok
  end

    def location
      carrier.update(
        location: params[:location],
        viable: false
      )
    end

      def destroy
        carrier.destroy
      end

      def dashboard
        # jobs = Order.where(location: @current_carrier.location, dispatched: false, prepared: true)
        jobs = Order.all
        render json: jobs, status: :ok, each_serializer: JobSerializer
      end
      
      def register_job
        job = Delivery.new(
          order_id: params[:order_id],
          carrier_id: params[:carrier_id]
        )
        
        if job.save!
          order = Order.find(params[:order_id]).toggle!(:dispatched)
          jobs = Order.where(location: @current_carrier.location, dispatched: false)
          render json: jobs, status: :ok, each_serializer: JobSerializer
          else
            render json: {error: job.errors.full_messages}, status: :error
        end
      end
      
      def toggle_delivered
        order = Order.find(params[:order_id])
        
        if order.toggle!(:delivered)
          o = @current_carrier.increment!(:delivery_count)
          jobs = @current_carrier.orders
          render json: jobs, status: :ok, each_serializer: JobSerializer
          else
            render json: {error: job.errors.full_messages}, status: :error
        end
      end

      def jobs 
        jobs = @current_carrier.orders
        render json: jobs, status: :ok, each_serializer: JobSerializer
      end

      private  
        def carrier_params
            params.permit(:carrier, :first_name, :last_name, :email, :location, :carriername, :password, :phone_number, :vehicle_type)
        end

        def delivery_params
          params.permit(:order_id, :carrier_id, :carrier)
        end
    end
  end
end