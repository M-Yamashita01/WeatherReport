require_relative 'location_weather'

class LocationWeatherList
  def initialize
    @array = Array.new
  end

  # location_weather: LocationWeather
  def push(location_weather)
    @array.push(location_weather)
  end

  def count
    return @array.count
  end

  def pop
    return @array.pop
  end

  def get_list
    return @array
  end
end
