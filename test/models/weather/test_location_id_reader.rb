require 'test-unit'
require_relative '../../../app/models/weather/location_id_reader'
require_relative '../../../app/models/weather/location_list'

class TestLocationIdReader < Test::Unit::TestCase
  def test_all_location_count
    reader = LocationIdReader.new
    location_list = reader.read_all_location_id
    assert_equal 142, location_list.count
  end

  def test_main_location_count
    reader = LocationIdReader.new
    location_list = reader.read_main_location_id
    assert_equal 21, location_list.count
  end
end
