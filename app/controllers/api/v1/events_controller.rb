module Api
  module V1
    class EventsController < ApplicationController
      # GET /events
      # GET /events.json
      def index
        # to do - badly optimized
        @schedule = Schedule.find(params[:schedule_id])
        @events = @schedule.events 

        render json: @events
      end

      # GET /events/1
      # GET /events/1.json
      def show
        # to do - badly optimized
        @schedule = Schedule.find(params[:schedule_id])
        @event = @schedule.events.find(params[:id]) 

        render json: @event
      end

      # POST /events
      # POST /events.json
      def create
        @schedule = Schedule.find(params[:schedule_id]) 
        @event = @schedule.events.new(event_params)

        if @event.save
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /events/1
      # PATCH/PUT /events/1.json
      def update
        @schedule = Schedule.find(params[:schedule_id]) 
        @event = @schedule.events.find(params[:id])

        if @event.update(event_params)
          head :no_content
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /events/1
      # DELETE /events/1.json
      def destroy
        @schedule = Schedule.find(params[:schedule_id]) 
        @event = @schedule.events.find(params[:id])
        @event.destroy

        head :no_content
      end

      private
        def event_params
          params.require(:event).permit(:name, :start_time, :end_time,:address, :city, :state, :zip_code,:latitude, :longitude, :schedule_id)
        end
      
    end
  end
end
