# frozen_string_literal: true

module Api
  class MinutesForecastsController < ApplicationController
    before_action :set_minutes_forecast, only: [:show, :update, :destroy]

    # GET /minutes_forecasts
    # GET /minutes_forecasts.json
    def index
      @minutes_forecasts = Forecast.all
    end

    # GET /minutes_forecasts/1
    # GET /minutes_forecasts/1.json
    def show
      # nothing
    end

    # POST /minutes_forecasts
    # POST /minutes_forecasts.json
    def create
      @minutes_forecast = Forecast.new(minutes_forecast_params)

      if @minutes_forecast.save
        render :show, status: :created, location: @minutes_forecast
      else
        render json: @minutes_forecast.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /minutes_forecasts/1
    # PATCH/PUT /minutes_forecasts/1.json
    def update
      if @minutes_forecast.update(minutes_forecast_params)
        render :show, status: :ok, location: @minutes_forecast
      else
        render json: @minutes_forecast.errors, status: :unprocessable_entity
      end
    end

    # DELETE /minutes_forecasts/1
    # DELETE /minutes_forecasts/1.json
    def destroy
      @minutes_forecast.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_minutes_forecast
      @minutes_forecast = Forecast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def minutes_forecast_params
      params.fetch(:minutes_forecast, {})
    end
  end
end
