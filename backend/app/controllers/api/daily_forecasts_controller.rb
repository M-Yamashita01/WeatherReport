class DailyForecastsController < ApplicationController
  before_action :set_daily_forecast, only: [:show, :update, :destroy]

  # GET /daily_forecasts
  # GET /daily_forecasts.json
  def index
    @daily_forecasts = DailyForecast.all
  end

  # GET /daily_forecasts/1
  # GET /daily_forecasts/1.json
  def show
  end

  # POST /daily_forecasts
  # POST /daily_forecasts.json
  def create
    @daily_forecast = DailyForecast.new(daily_forecast_params)

    if @daily_forecast.save
      render :show, status: :created, location: @daily_forecast
    else
      render json: @daily_forecast.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /daily_forecasts/1
  # PATCH/PUT /daily_forecasts/1.json
  def update
    if @daily_forecast.update(daily_forecast_params)
      render :show, status: :ok, location: @daily_forecast
    else
      render json: @daily_forecast.errors, status: :unprocessable_entity
    end
  end

  # DELETE /daily_forecasts/1
  # DELETE /daily_forecasts/1.json
  def destroy
    @daily_forecast.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_forecast
      @daily_forecast = DailyForecast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def daily_forecast_params
      params.fetch(:daily_forecast, {})
    end
end
