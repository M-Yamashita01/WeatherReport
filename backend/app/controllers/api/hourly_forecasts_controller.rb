module Api
  class HourlyForecastsController < ApplicationController
    before_action :set_hourly_forecast, only: [:show, :update, :destroy]

    # GET /hourly_forecasts
    # GET /hourly_forecasts.json
    def index
      @hourly_forecasts = Forecast.all
    end

    # GET /hourly_forecasts/1
    # GET /hourly_forecasts/1.json
    def show
    end

    # POST /hourly_forecasts
    # POST /hourly_forecasts.json
    def create
      @hourly_forecast = Forecast.new(hourly_forecast_params)

      if @hourly_forecast.save
        render :show, status: :created, location: @hourly_forecast
      else
        render json: @hourly_forecast.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /hourly_forecasts/1
    # PATCH/PUT /hourly_forecasts/1.json
    def update
      if @hourly_forecast.update(hourly_forecast_params)
        render :show, status: :ok, location: @hourly_forecast
      else
        render json: @hourly_forecast.errors, status: :unprocessable_entity
      end
    end

    # DELETE /hourly_forecasts/1
    # DELETE /hourly_forecasts/1.json
    def destroy
      @hourly_forecast.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_hourly_forecast
        @hourly_forecast = Forecast.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def hourly_forecast_params
        params.fetch(:hourly_forecast, {})
      end
  end
end
