require 'open-uri'
require 'json'
require 'time'

# JSON形式のデータを読み込むクラス
class DataReader
  def read(url)
    response = URI.open(url)
    @parse_text = JSON.parse(response.read)
  end

  # JSON形式に天気データがある。
  # 今日、明日、あさっての天気がJSON内の配列内にあるため、数字を指定する
  def get_date(date_no)
    return @parse_text['forecasts'][date_no]['date']
  end

  def get_area_name
    return @parse_text['location']['area']
  end

  def get_prefecture_name
    return @parse_text['location']['pref']
  end

  def get_city_name
    return @parse_text['location']['city']
  end

  def get_date_label(date_no)
    return @parse_text['forecasts'][date_no]['dateLabel']
  end

  def get_weather_telop(date_no)
    return @parse_text['forecasts'][date_no]['telop']
  end

  def get_weather_image_no(date_no)
    url = @parse_text['forecasts'][date_no]['image']['url']
    url.slice!('http://weather.livedoor.com/img/icon/')
    return File.basename(url, '.*')
  end

  def get_weather_image_url(date_no)
    return @parse_text['forecasts'][date_no]['image']['url']
  end

  def get_highest_temperature(date_no)
    return @parse_text['forecasts'][date_no]['temperature']['max'].nil? ? -999 : @parse_text['forecasts'][date_no]['temperature']['max']['celsius']
  end

  def get_lowest_temperature(date_no)
    return @parse_text['forecasts'][date_no]['temperature']['min'].nil? ? -999 : @parse_text['forecasts'][date_no]['temperature']['min']['celsius']
  end

  def get_weather_url
    return @parse_text['link']
  end

  def get_public_time
    public_time = @parse_text['publicTime']
    return Time.parse(public_time).strftime("%Y-%m-%d %H:%M:%S")
  end
end
