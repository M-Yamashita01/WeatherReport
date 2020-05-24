require 'test/unit'
require_relative '../../openWeatherMap/current_weathers_getter.rb'

class TestCurrentWeatherGetter < Test::Unit::TestCase
  def self.startup
    @@api_key = ENV["OPENWEATHERMAP_API_KEY"]
  end

  def self.shutdown
    ENV["OPENWEATHERMAP_API_KEY"] = @@api_key
  end

  def test_get_weather_by_invalid_api_key
    ENV["OPENWEATHERMAP_API_KEY"] = "0"
    current_weather = CurrentWeathersGetter.new
    assert_equal "", current_weather.get_weather(1861387)
  end

  def test_get_weather_by_valid_api_key
    ENV["OPENWEATHERMAP_API_KEY"] = @@api_key
    current_weather = CurrentWeathersGetter.new
    assert_equal "Ishikawa", current_weather.get_weather(1861387).city_name
  end    
end
