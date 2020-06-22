module Api
    module V1
        class MealsController < Api::V1::BaseController
            def index
                @meals = Meal.all
                render json: {meals: @meals, staus: :ok}
            end
        end
    end
end