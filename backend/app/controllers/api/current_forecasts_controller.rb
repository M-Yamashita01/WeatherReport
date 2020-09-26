module Api
  class CurrentForecastsController < ApplicationController
    before_action :set_current_forecast, only: [:show, :update, :destroy]

    # GET /current_forecasts
    # GET /current_forecasts.json
    def index
      @current_forecasts = Forecast.all
    end

    # GET /current_forecasts/1
    # GET /current_forecasts/1.json
    def show
    end

    # POST /current_forecasts
    # POST /current_forecasts.json
    def create
      @current_forecast = Forecast.new(current_forecast_params)

      if @current_forecast.save
        render :show, status: :created, location: @current_forecast
      else
        render json: @current_forecast.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /current_forecasts/1
    # PATCH/PUT /current_forecasts/1.json
    def update
      if @current_forecast.update(current_forecast_params)
        render :show, status: :ok, location: @current_forecast
      else
        render json: @current_forecast.errors, status: :unprocessable_entity
      end
    end

    # DELETE /current_forecasts/1
    # DELETE /current_forecasts/1.json
    def destroy
      @current_forecast.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_current_forecast
        @current_forecast = Forecast.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def current_forecast_params
        params.fetch(:current_forecast, {})
      end
  end
end
