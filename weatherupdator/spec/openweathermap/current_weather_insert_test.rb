require 'test/unit'
require_relative '../../openWeatherMap/current_weather_insert.rb'

class CurrentWeatherInsertTest < Test::Unit::TestCase
  def self.startup
    @@api_key = ENV["OPENWEATHERMAP_API_KEY"]
  end

  def self.shutdown
    ENV["OPENWEATHERMAP_API_KEY"] = @@api_key
  end

  def test_insert_weather_by_invalid_api_key
    ENV["OPENWEATHERMAP_API_KEY"] = "0"
    CurrentWeatherInsert.new
    assert_nothings_raised
  end
end
