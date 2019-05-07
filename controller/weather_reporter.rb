require_relative '../model/weather_collection'
require_relative '../model/location_weather_list'
require_relative '../model/location_weather'
require_relative '../view/weather_display'

class WeatherReporter
  def initialize(weather_collection, weahter_display)
    @weather_collection = weather_collection
    @weahter_display = weahter_display
  end

  def report_today_weather
    location_weather_list = @weather_collection.get_all_location_weather
    weather_count = location_weather_list.count

    weather_display = WeatherDisplay.new
    for i in 0..weather_count - 1
      location_weather = location_weather_list.pop
      weather_display.display(location_weather.city_name, location_weather.today_weather)
    end
  end
end
