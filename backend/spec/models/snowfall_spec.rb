require 'rails_helper'

RSpec.describe Snowfall, type: :model do
  let(:location) { create(:city) }
  let(:forecast) { location.forecasts.create!(forecast_type: "current", weathermap_location_id: location.id)}

  context '過去1時間の雪量(mm)を入れた場合' do
    let(:snowfall) { forecast.snowfalls.create(snow_volume_last_hour: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(snowfall).to be_valid
    end
  end

  context '降雪量(mm)を入れた場合' do
    let(:snowfall) { forecast.snowfalls.create(snow_volume: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(snowfall).to be_valid
    end
  end
end
