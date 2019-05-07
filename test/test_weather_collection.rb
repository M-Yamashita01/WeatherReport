require 'test-unit'
require_relative '../model/url_creator'
require_relative '../model/weather_collection'
require_relative '../model/location_weather'
require_relative '../model/location_weather_list'
require_relative 'mock/data_reader_mock'

class TestWeatherCollection < Test::Unit::TestCase
  def test_get_weather_location_point
    creator = URLCreator.new
    reader = DataReaderMock.new

    weather_collection = WeatherCollection.new(creator, reader)

    location_weather_list = weather_collection.get_all_location_weather

    assert_equal 142, location_weather_list.count
  end

  def test_get_weather_date
    creator = URLCreator.new
    reader = DataReaderMock.new

    weather_collection = WeatherCollection.new(creator, reader)

    location_weather_list = weather_collection.get_all_location_weather
    location_count = location_weather_list.count
    for i in 0..location_count - 1
      location_weather = location_weather_list.pop
      assert_equal Date.today.strftime('%Y-%m-%d'), location_weather.today_date
    end
  end
end
