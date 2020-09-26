require 'rails_helper'

RSpec.describe AtmosphericPressure, type: :model do
  let(:location) { create(:city) }
  let(:forecast) { location.forecasts.create!(forecast_type: "current", weathermap_location_id: location.id)}

  context '大気圧を入れた場合' do
    let(:pressure) { forecast.atmospheric_pressures.create(atmospheric_pressure: 0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(pressure).to be_valid
    end
  end
end
