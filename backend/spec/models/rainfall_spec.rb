# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rainfall, type: :model do
  let(:location) { create(:tokyo) }
  let(:forecast) { create(:forecast, :current, weathermap_location_id: location.id) }

  context '過去1時間の雨量(mm)を入れた場合' do
    let(:rainfall) { forecast.rainfalls.create(rain_volume_last_hour: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(rainfall).to be_valid
    end
  end

  context '降水確率を入れた場合' do
    let(:rainfall) { forecast.rainfalls.create(probability_of_precipitation: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(rainfall).to be_valid
    end
  end

  context '降水量(mm)を入れた場合' do
    let(:rainfall) { forecast.rainfalls.create(precipitation_of_volume: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(rainfall).to be_valid
    end
  end
end
