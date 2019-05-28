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
  # 戻り値：LocationWeatherList
  def get_main_location_weather
    id_reader = LocationIdReader.new
    location_list = id_reader.read_main_location_id

    return create_weather_location_list(location_list)
  end

  private

  # LocationListから天気情報リストを作成します。
  # location_weather_list: LocationWeatherList
  def create_weather_location_list(location_list)
    location_weather_list = LocationWeatherList.new
    location_count = location_list.count

    begin
      for i in 0..location_count - 1
        location = location_list.get
        url = @creator.create(location.id)
        @reader.read(url)

        location_weather = LocationWeather.new
        # 0は今日をあらわす
        location_weather.today_weather = @reader.get_weather_telop(0)
        location_weather.today_date = @reader.get_date(0)
        location_weather.city_name = @reader.get_city_name
        location_weather.today_weather_image_path = @reader.get_weather_image_file_name(0)
        location_weather_list.push(location_weather)
    end
    rescue StandardError
      location_weather = LocationWeather.new
      location_weather.today_weather = '-'
      location_weather.today_date = Date.today.strftime('%Y-%m-%d')
      location_weather.city_name = '-'
      location_weather.today_weather_image_path = '1.gif' #exception用に？の画像を用意すること
      location_weather_list.push(location_weather)
    end

    return location_weather_list
  end
end
