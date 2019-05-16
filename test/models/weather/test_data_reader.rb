require 'test-unit'
require_relative 'mock/data_reader_mock'

class TestDataReader < Test::Unit::TestCase
  def test_get_date
    url = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'
    reader = DataReaderMock.new
    reader.read(url)
    assert_equal Date.today.strftime('%Y-%m-%d'), reader.get_date(0)
  end
end
