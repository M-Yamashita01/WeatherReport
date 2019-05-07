require 'test-unit'
require_relative '../model/location_id_reader'
require_relative '../model/location_list'

class TestLocationIdReader < Test::Unit::TestCase
  def test_list_size
    reader = LocationIdReader.new
    location_list = reader.read
    assert_equal 142, location_list.count
  end
end
