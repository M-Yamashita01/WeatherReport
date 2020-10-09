# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Temperature, type: :model do
  let(:location) { create(:tokyo) }
  let(:forecast) { create(:forecast, :current, weathermap_location_id: location.id) }

  context '気温を入れた場合' do
    let(:temperature) { forecast.temperatures.create(temperature: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(temperature).to be_valid
    end
  end

  context '朝の気温を入れた場合' do
    let(:temperature) { forecast.temperatures.create(morning_temperature: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(temperature).to be_valid
    end
  end

  context '昼の気温を入れた場合' do
    let(:temperature) { forecast.temperatures.create(daytime_temperature: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(temperature).to be_valid
    end
  end

  context '夕方の気温を入れた場合' do
    let(:temperature) { forecast.temperatures.create(evening_temperature: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(temperature).to be_valid
    end
  end

  context '夜の気温を入れた場合' do
    let(:temperature) { forecast.temperatures.create(night_temperature: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(temperature).to be_valid
    end
  end

  context '最高気温を入れた場合' do
    let(:temperature) { forecast.temperatures.create(maximum_temperature: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(temperature).to be_valid
    end
  end

  context '最低気温を入れた場合' do
    let(:temperature) { forecast.temperatures.create(minimum_temperature: 0.0, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(temperature).to be_valid
    end
  end
end
