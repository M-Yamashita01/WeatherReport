require 'rails_helper'

RSpec.describe Cloud, type: :model do
  let(:location) { create(:tokyo) }
  let!(:forecast) { location.forecasts.create(forecast_datetime: DateTime.now, forecast_type: "current", weathermap_location_id: location.id)}

  context '雲の量(%)を入れた場合' do
    let(:cloud) { forecast.clouds.create(cloudiness: 50, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(cloud).to be_valid
    end
  end
end
