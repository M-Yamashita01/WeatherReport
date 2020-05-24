require 'test/unit'
require_relative '../../openWeatherMap/city_id_reader.rb'

class TestCityIdReader < Test::Unit::TestCase
  def test_get_city_id_list
    id_reader = CityIdReader.new
    city_id_list_jp = id_reader.read_city_id('JP')
    assert_equal 1861387, city_id_list_jp[0]["id"]
  end
end
