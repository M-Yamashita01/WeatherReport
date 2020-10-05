require 'rails_helper'

RSpec.describe "DailyForecasts", type: :request do
  describe "GET /api/daily_forecasts" do
    subject { get api_daily_forecasts_path, params: params }

    context 'パラメータに緯度、経度が与えられたとき' do
      let!(:location) { create(:tokyo) }
      let!(:forecast) { location.forecasts.create(forecast_type: "daily")}
      let(:now_datetime) { DateTime.now }
      let!(:sunriseset) { forecast.sunrisesets.create(sunrise_at: now_datetime, sunset_at: now_datetime )}
      let(:params) { { latitude: 139.691, longitude: 35.689 } }

      it "日の出時間が取得できること" do
        subject
        json = JSON.parse(response.body)
        sunrise_at = json['daily_forecast']['sunrise_at']
        expect(DateTime.parse(sunrise_at).to_i).to eq now_datetime.to_i
      end

      it "日の入時間が取得できること" do
        subject
        json = JSON.parse(response.body)
        sunset_at = json['daily_forecast']['sunset_at']
        expect(DateTime.parse(sunset_at).to_i).to eq now_datetime.to_i
      end
    end
  end
end
