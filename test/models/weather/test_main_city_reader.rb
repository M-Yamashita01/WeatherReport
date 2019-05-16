require 'test-unit'
require_relative '../../../app/models/weather/main_city_reader'

class TestMainCityReader < Test::Unit::TestCase
  def test_contain_main_city
    reader = MainCityReader.new
    reader.read
    assert_equal true, reader.contain?('東京')
  end

  def test_not_contain_main_city
    reader = MainCityReader.new
    reader.read
    assert_equal true, reader.contain?('千葉')
  end
end
