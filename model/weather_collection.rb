require_relative 'url_creator'
require_relative 'data_reader'
require_relative 'location_list'
require_relative 'location_id_reader'
require_relative 'location_weather'

class WeatherCollection
  def initialize(creator, reader)
    @creator = creator
    @reader = reader
  end

  # 全国の各地点IDから天気を取得します。
  # 戻り値：LocationWeather
  def get_all_location_weather
    id_reader = LocationIdReader.new
    location_list = id_reader.read

    return create_weather_location_list(location_list)
  end

  private

  # LocationListから天気情報リストを作成します。
  # location_list: LocationList
  def create_weather_location_list(location_list)
    location_weather_list = LocationWeatherList.new
    location_count = location_list.count
    for i in 0..location_count - 1
      location = location_list.get
      url = @creator.create(location.id)
      @reader.read(url)

      location_weather = LocationWeather.new
      # 0は今日をあらわす
      location_weather.today_weather = @reader.get_weather_telop(0)
      location_weather.today_date = @reader.get_date(0)
      location_weather.city_name = @reader.get_city_name
      location_weather_list.push(location_weather)
    end

    return location_weather_list
  end
end
