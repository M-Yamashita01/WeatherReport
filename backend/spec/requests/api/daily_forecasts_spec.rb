# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DailyForecasts', type: :request do
  describe 'GET /api/daily_forecasts' do
    subject { get api_daily_forecasts_path, params: params }

    context 'パラメータに緯度、経度が与えられたとき' do
      let(:now_datetime) { DateTime.now }
      let!(:location) { create(:tokyo) }
      let!(:forecast) {
        location.forecasts.create(forecast_datetime: DateTime.now,
                                  forecast_type: 'daily')
      }
      let!(:sunriseset) { forecast.sunrisesets.create(sunrise_at: now_datetime, sunset_at: now_datetime) }
      let!(:temperature) { forecast.temperatures.create(temperature: 293.28) }
      let!(:atmospheric_pressure) { forecast.atmospheric_pressures.create(atmospheric_pressure: 1016) }
      let!(:humidity) { forecast.humidities.create(humidity: 100) }
      let!(:cloud) { forecast.clouds.create(cloudiness: 90) }
      let!(:uv_index) { forecast.uv_indices.create(midday_uv_index: 10.64) }
      let!(:wind) { forecast.winds.create(wind_speed: 4.6, wind_gust: 15.65, wind_direction: 60) }
      let!(:rainfall) { forecast.rainfalls.create(rain_volume_last_hour: 2.93) }
      let!(:snowfall) { forecast.snowfalls.create(snow_volume_last_hour: 2.93) }
      let!(:weather_group) {
        forecast.weather_groups.create(weather_group_id: 1,
                                       weather_icon: '10d',
                                       weather_main: 'Rain',
                                       weather_description: 'heavy intensity rain')
      }

      let(:params) { { latitude: 139.691, longitude: 35.689 } }

      it '週の日の出時間が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_sunrise_at = json['daily_forecast']['sunrise_at']
        expect(DateTime.parse(daily_sunrise_at).to_i).to eq now_datetime.to_i
      end

      it '週の日の入時間が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_sunset_at = json['daily_forecast']['sunset_at']
        expect(DateTime.parse(daily_sunset_at).to_i).to eq now_datetime.to_i
      end

      it '週の気温が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_temperature = json['daily_forecast']['temperature']
        expect(daily_temperature).to eq 293.28
      end

      it '週の気圧が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_atmospheric_pressure = json['daily_forecast']['atmospheric_pressure']
        expect(daily_atmospheric_pressure).to eq 1016
      end

      it '週の湿度が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_humidty = json['daily_forecast']['humidity']
        expect(daily_humidty).to eq humidity.humidity
      end

      it '週の雲の量が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_cloudiness = json['daily_forecast']['cloudiness']
        expect(daily_cloudiness).to eq cloud.cloudiness
      end

      it '週の紫外線指数が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_midday_uv_index = json['daily_forecast']['midday_uv_index']
        expect(daily_midday_uv_index).to eq uv_index.midday_uv_index
      end

      it '週の風速、最大瞬間風速、風向が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_wind_speed = json['daily_forecast']['wind_speed']
        expect(daily_wind_speed).to eq wind.wind_speed
        daily_wind_gust = json['daily_forecast']['wind_gust']
        expect(daily_wind_gust).to eq wind.wind_gust
        daily_wind_direction = json['daily_forecast']['wind_direction']
        expect(daily_wind_direction).to eq wind.wind_direction
      end

      it '週の降雨量(過去1時間)が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_rain_volume_last_hour = json['daily_forecast']['rain_volume_last_hour']
        expect(daily_rain_volume_last_hour).to eq rainfall.rain_volume_last_hour
      end

      it '週の降雪量(過去1時間)が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_snow_volume_last_hour = json['daily_forecast']['snow_volume_last_hour']
        expect(daily_snow_volume_last_hour).to eq snowfall.snow_volume_last_hour
      end

      it '週の天気id、アイコン、概要、説明が取得できること' do
        subject
        json = JSON.parse(response.body)
        daily_weather_group_id = json['daily_forecast']['weather_group_id']
        expect(daily_weather_group_id).to eq weather_group.weather_group_id
        daily_weather_icon = json['daily_forecast']['weather_icon']
        expect(daily_weather_icon).to eq weather_group.weather_icon
        daily_weather_main = json['daily_forecast']['weather_main']
        expect(daily_weather_main).to eq weather_group.weather_main
        daily_weather_description = json['daily_forecast']['weather_description']
        expect(daily_weather_description).to eq weather_group.weather_description
      end
    end
  end
end
