require 'rails_helper'

RSpec.describe Forecast, type: :model do
  context '現在を表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "current", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '分ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "minutely", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '時間ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "hourly", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '日ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "daily", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '適当な文字(hogehoge)のレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "hogehoge", weathermap_location_id: location.id) }
    it 'validationがpassしないこと' do
      expect(forecast).not_to be_valid
    end
  end
end
