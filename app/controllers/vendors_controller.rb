class VendorsController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_vendor, except: %i[create index]

    def index
        @vendors = Vendor.all
        render json: @vendors, status: :ok
    end

    def show
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

    def destroy
        @vendor.destroy
    end

    private
    def find_vendor
        @vendor = Vendor.find_by_vendorname!(params[:_vendorname])
        rescue ActiveRecord::RecordNotFound
            render json: {errors: 'vendor not found'}, status: :not_found
    end

    def vendor_params
        params.permit(:logo, :vendorname, :email, :password, :password_confirmation, :phone_number)
    end
end
