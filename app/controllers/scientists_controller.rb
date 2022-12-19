class ScientistsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_error_scientist_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_error_scientist_invalid

    def index
        scientists = Scientist.all
        render json: scientists
    end

    def show
        scientist = find_scientist
        render json: scientist, serializer: ScientistwithplanetSerializer
    end

    def create
        new_scientist = Scientist.create!(scientist_params)
        render json: new_scientist, status: :created
    end

    def update
        updated_scientist = find_scientist
        updated_scientist.update!(scientist_params)
        render json: updated_scientist, status: :accepted
    end

    def destroy
        destroy_scientist = find_scientist
        destroy_scientist.destroy
        render json: {}
    end

    private

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def find_scientist
        Scientist.find(params[:id])
    end

    def render_error_scientist_not_found
        render json: { error: "Scientist Not Found" }, status: :not_found
    end

    def render_error_scientist_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
