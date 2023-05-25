class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

    #POST /signups
    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    end


    private

    def signup_params
        params.permit(:activity_id, :camper_id, :time)
    end
        
    def record_not_found_response
        render json:{error: "Signup not found"}, status: :not_found
    end

    def render_unprocessable_entity_response (invalid)
        render json: {errors: [invalid.record.errors]}, status: :unprocessable_entity 
    end
end
