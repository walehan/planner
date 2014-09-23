module Api
  module V1
    class SchedulesController < ApplicationController
      # GET /schedules
      # GET /schedules.json
      def index
        @schedules = Schedule.all

        render json: @schedules
      end

      # GET /schedules/1
      # GET /schedules/1.json
      def show
        @schedule = Schedule.find(params[:id])

        render json: @schedule
      end

      # POST /schedules
      # POST /schedules.json
      def create
        @schedule = Schedule.new(params[:schedule])

        if @schedule.save
          render json: @schedule, status: :created, location: @schedule
        else
          render json: @schedule.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /schedules/1
      # PATCH/PUT /schedules/1.json
      def update
        @schedule = Schedule.find(params[:id])

        if @schedule.update(params[:schedule])
          head :no_content
        else
          render json: @schedule.errors, status: :unprocessable_entity
        end
      end

      # DELETE /schedules/1
      # DELETE /schedules/1.json
      def destroy
        @schedule = Schedule.find(params[:id])
        @schedule.destroy

        head :no_content
      end
    end
  end
end
