require 'rails_helper'

RSpec.describe Humidity, type: :model do
  let(:location) { create(:tokyo) }
  let(:forecast) { location.forecasts.create!(forecast_type: "current", weathermap_location_id: location.id)}

  context '湿度(%)を入れた場合' do
    let(:humidity) { forecast.humidities.create(humidity: 50, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(humidity).to be_valid
    end
  end
end
