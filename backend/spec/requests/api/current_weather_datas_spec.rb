# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CurrentWeatherDatas', type: :request do
  describe 'GET /current_weather_datas' do
    context '登録されている地域の天気が1つのみの場合' do
      let(:weathermap_location) { create(:tokyo) }
      let(:forecast) { create(:forecast, :current, weathermap_location_id: weathermap_location.id) }
      let(:weather_group) { create(:weather_sunny, forecast_id: forecast.id) }
      let!(:current_weather) {
        create(:current_weather_sample,
               weathermap_location: weathermap_location,
               weather_group: weather_group)
      }

      it '地域の天気1件のみ取得できること' do
        get '/api/current_weather_datas'
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
        expect(json['current_weather_data'].length).to eq 1
      end
    end
  end

  describe 'GET /current_weather_datas?longitude_max=&longitude_min=&latitude_max=&latitude_min=' do
    context '登録されている地域の天気が1つのみで、緯度経度を指定せずに天気を取得した場合' do
      let(:weathermap_location) { create(:tokyo) }
      let(:forecast) {
        weathermap_location.forecasts.create(forecast_datetime: DateTime.now,
                                             forecast_type: 'current')
      }
      let(:weather_group) { create(:weather_sunny, forecast_id: forecast.id) }
      let!(:current_weather) {
        create(:current_weather_sample,
               weathermap_location: weathermap_location,
               weather_group: weather_group)
      }

      it '地域の天気1件のみ取得できること' do
        get '/api/current_weather_datas?longitude_max=&longitude_min=&latitude_max=&latitude_min='
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
        expect(json['current_weather_data'].length).to eq 1
      end
    end
  end
end
