require 'rails_helper'

RSpec.describe "DailyForecasts", type: :request do
  describe "GET /api/daily_forecasts" do
    subject { get api_daily_forecasts_path, params: params }

    context 'パラメータに緯度、経度が与えられたとき' do
      let!(:location) { create(:tokyo) }
      let!(:forecast) { location.forecasts.create(forecast_type: "daily")}
      let(:params) { { latitude: 139.691, longitude: 35.689 } }

      it "works! (now write some real specs)" do
        subject
        expect(response).to have_http_status(200)
      end

      it "都市名を取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(json['daily_forecast']['city_name']).to eq "tokyo"
      end
    end
  end
end
