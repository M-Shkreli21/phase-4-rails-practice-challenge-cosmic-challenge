class MissionsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_error_mission_invalid

    def create
        new_mission = Mission.create!(mission_params)
        render json: new_mission.planet, status: :created
    end

    private

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end


    def render_error_mission_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
