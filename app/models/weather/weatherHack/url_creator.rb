class URLCreator
  BASE_URL = 'http://weather.livedoor.com/forecast/webservice/json/v1?city='.freeze

  def create(location_id)
    return BASE_URL + location_id.to_s
  end
end
