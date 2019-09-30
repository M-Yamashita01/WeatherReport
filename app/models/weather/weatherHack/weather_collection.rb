require_relative 'url_creator'
require_relative 'data_reader'
require_relative 'location_list'
require_relative 'location_id_reader'
require_relative 'location_weather'
require 'logger'

class WeatherCollection
  def initialize(creator, reader)
    @creator = creator
    @reader = reader
    @log = Logger.new('./rubyfile.log')
  end

  # 全国の各地点IDから天気を取得します。
  # 戻り値：LocationWeatherList
  def get_main_location_weather
    id_reader = LocationIdReader.new
    location_list = id_reader.read_main_location_id

    return create_weather_location_list(location_list)
  end

  def get_all_location_weather(date_no)
    id_reader = LocationIdReader.new
    location_list = id_reader.read_all_location_id

    return create_weather_location_list(location_list, date_no)
  end

  def get_location_weather_in_area(area_name)
    id_reader = LocationIdReader.new
    location_list = id_reader.read_location_id_in_area(area_name)

    return create_weather_location_list(location_list)
  end

  private

  # LocationListから天気情報リストを作成します。
  # location_weather_list: LocationWeatherList
  def create_weather_location_list(location_list, date_no)
    location_weather_list = LocationWeatherList.new
    location_count = location_list.count

    for i in 0..location_count - 1
      location = location_list.get

      # 地方名、県名は変化しないので先に設定しておく
      location_weather = LocationWeather.new
      location_weather.location_id = location.id

      begin
        url = @creator.create(location.id)
        @reader.read(url)

        # 0は今日をあらわす
        location_weather.date = @reader.get_date(date_no)
        location_weather.area_name = @reader.get_area_name
        location_weather.prefecture_name = @reader.get_prefecture_name
        location_weather.city_name = @reader.get_city_name

        location_weather.date_label = @reader.get_date_label(date_no)
        location_weather.telop = @reader.get_weather_telop(date_no)
        location_weather.weather_image_url = @reader.get_weather_image_url(date_no)
        location_weather.highest_temperature = @reader.get_highest_temperature(date_no)
        location_weather.lowest_temperature = @reader.get_lowest_temperature(date_no)
        location_weather.weather_url = @reader.get_weather_url
        location_weather.public_time = @reader.get_public_time
      rescue StandardError => e
        @log.error(e.to_s)
        location_weather.date = Date.today.strftime('%Y-%m-%d')
        location_weather.area_name = '---'
        location_weather.prefecture_name = '---'
        location_weather.city_name = '---'

        location_weather.date_label = '---'
        location_weather.telop = 'none'
        location_weather.weather_image_no = 0
        location_weather.highest_temperature = 999
        location_weather.lowest_temperature = 999
        location_weather.weather_url = '---'
        # location_weather.public_time = DateTime.
      end

      location_weather_list.push(location_weather)
    end

    return location_weather_list
  end
end
