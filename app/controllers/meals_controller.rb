class MealsController < ApplicationController
    def index
        @meals = Meal.all
        render json: @meals, staus: :ok
    end
end