class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response


    #GET /campers
    def index
        render json: Camper.all, include: [:signups], status: :ok
    end

    #GET /campers/:id
    def show
        render json: Camper.find(params[:id]), status: :ok
    end

    #POST /campers
    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end
        
    def record_not_found_response
        render json:{"error": "Camper not found"}, status: :not_found
    end
    
    def render_unprocessable_entity_response (invalid)
        render json: {errors: [invalid.record.errors]}, status: :unprocessable_entity 
    end

end
