class CurrentWeather
  attr_accessor :longitude
  attr_accessor :latitude
  attr_accessor :city_id
  attr_accessor :city_name

  attr_accessor :weather_group_id
  attr_accessor :weather_icon
  attr_accessor :weather_main
  attr_accessor :weather_description

  attr_accessor :temperature
  attr_accessor :pressure
  attr_accessor :humidity
  attr_accessor :temperature_min
  attr_accessor :temperature_max
  attr_accessor :wind_speed
  attr_accessor :wind_degree
  attr_accessor :cloudiness
  attr_accessor :rain_1h
  attr_accessor :rain_3h
  attr_accessor :snow_1h
  attr_accessor :snow_3h
  attr_accessor :sunrise
  attr_accessor :sunset
  attr_accessor :country_code

  def initialize
    @longitude = 0
    @latitude = 0
    @city_id = 0
    @city_name = ''
    @weather_group_id = 0
    @weather_icon = 0
    @weather_main = ''
    @weather_description = ''
    @temeprature = 0
    @pressure = 0
    @humidity = 0
    @temeprature_min = 0
    @temeprature_max = 0
    @wind_speed = 0
    @wind_degree = 0
    @cloudiness = 0
    @rain_1h = 0
    @rain_3h = 0
    @snow_1h = 0
    @snow_3h = 0
    @sunrise = 0
    @sunset = 0
    @country_code = ''
  end
end
