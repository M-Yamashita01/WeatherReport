require_relative '../../../app/models/weather/weatherHack/url_creator'
require_relative '../../../app/models/weather/weatherHack/weather_collection'
require_relative '../../../app/models/weather/weatherHack/location_weather'
require_relative '../../../app/models/weather/weatherHack/location_weather_list'
require_relative 'mock/data_reader_mock'

describe '天気情報取得' do
  context '地点数取得' do
    it '主要地点数取得' do
      creator = URLCreator.new
      reader = DataReaderMock.new
      weather_collection = WeatherCollection.new(creator, reader)
      location_weather_list = weather_collection.get_main_location_weather
      expect(21).to eq(location_weather_list.count)
    end
  end

  context '日付取得' do
    it '今日の日付取得' do
      creator = URLCreator.new
      reader = DataReaderMock.new
      weather_collection = WeatherCollection.new(creator, reader)
      location_weather_list = weather_collection.get_main_location_weather
      location_count = location_weather_list.count
      for i in 0..location_count - 1
        location_weather = location_weather_list.pop
        expect(Date.today.strftime('%Y-%m-%d')).to eq(location_weather.today_date)
      end
    end
  end
end
