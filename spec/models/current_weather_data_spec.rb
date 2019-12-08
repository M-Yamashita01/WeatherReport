require 'rails_helper'

RSpec.describe CurrentWeatherDatas, type: :model do
  before(:each) do
    @weathermap_location = FactoryBot.create(:city)
    @weather_group = FactoryBot.create(:weather_sunny)
    @current_weather = FactoryBot.build(:current_weather_sample, weathermap_location: @weathermap_location, weather_group: @weather_group)
  end

  describe '現在の天気情報が存在する場合' do
    it 'validationがpassすること'do
      expect(@current_weather).to be_valid
    end
  end

  describe '現在の天気情報の取得日時が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.acquired_datetime = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に地域情報が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.weathermap_location = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に天気グループが存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.weather_group = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に現在の気温が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.temperature = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に現在の気圧が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.pressure = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に現在の湿度が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.humidity = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に最低気温が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.temperature_min = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に最高気温が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.temperature_max = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に風速が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.wind_speed = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に風向が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.wind_degree = nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に雲の量が存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.cloudiness= nil
      expect(@current_weather).not_to be_valid
    end
  end

  describe '現在の天気情報に国コードが存在しない場合' do
    it 'validationがpassしないこと' do
      @current_weather.country_code = nil
      expect(@current_weather).not_to be_valid
    end
  end
end
