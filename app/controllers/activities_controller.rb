class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

    #GET /activities
    def index
        render json: Activity.all, status: :ok
    end

    #GET /activities/:id
    # def show
    #     render json: Activity.find(params[:id]), status: :ok
    # end

    #DELETE /activities/:id
    def destroy
        activity = Activity.find(params[:id])
        activity.destroy
        head :no_content
    end


    private

    def post_params
        params.permit(:category, :content, :title)
    end
        
    def record_not_found_response
        render json: {error: "Activity not found"}, status: :not_found
    end

    def render_unprocessable_entity_response (invalid)
        render json: {errors: [invalid.record.errors]}, status: :unprocessable_entity 
    end
end
