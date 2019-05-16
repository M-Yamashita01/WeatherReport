require 'test-unit'
require_relative '../../../app/models/weather/url_creator'

class TestURLCreator < Test::Unit::TestCase
  def test_get_url
    creator = URLCreator.new
    url = creator.create(400_010)
    expected_url = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=400010'
    assert_equal expected_url, url
  end
end
