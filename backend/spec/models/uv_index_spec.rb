require 'rails_helper'

RSpec.describe UvIndex, type: :model do
  let(:location) { create(:tokyo) }
  let!(:forecast) { location.forecasts.create(forecast_datetime: DateTime.now, forecast_type: "current", weathermap_location_id: location.id)}

  context 'UV指数を入れた場合' do
    let(:uv_index) { forecast.uv_indices.create(midday_uv_index: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(uv_index).to be_valid
    end
  end
end
