require_relative '../../model/data_reader'

class DataReaderMock < DataReader
  def read(_url)
    # nothing to do
  end

  def get_weather_telop(_date_no)
    return 'sunny'
  end

  def get_date(_date_no)
    return Date.today.strftime('%Y-%m-%d')
  end

  def get_city_name
    return 'tokyo'
  end
end
