    class MealsController < ApplicationController
        def index
            @meals = Meal.all
            render json: {meals: @meals, staus: :ok}
        end
    end