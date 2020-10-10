# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wind, type: :model do
  let(:location) { create(:tokyo) }
  let!(:forecast) { create(:forecast, :current, weathermap_location_id: location.id) }

  context '風速(m/s)を入れた場合' do
    let(:wind) { forecast.winds.create(wind_speed: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(wind).to be_valid
    end
  end

  context '最大瞬間風速(m/s)を入れた場合' do
    let(:wind) { forecast.winds.create(wind_gust: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(wind).to be_valid
    end
  end

  context '風向を入れた場合' do
    let(:wind) { forecast.winds.create(wind_direction: 0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(wind).to be_valid
    end
  end
end
