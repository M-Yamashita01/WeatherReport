require 'open-uri'
require 'json'

# JSON形式のデータを読み込むクラス
class DataReader
  def read(url)
    response = URI.open(url)
    @parse_text = JSON.parse(response.read)
  end

  # JSON形式に天気データがある。
  # 今日、明日、あさっての天気がJSON内の配列内にあるため、数字を指定する
  def get_weather_telop(date_no)
    return @parse_text['forecasts'][date_no]['telop']
  end

  def get_weather_image_no(date_no)
    url = @parse_text['forecasts'][date_no]['image']['url']
    url.slice!('http://weather.livedoor.com/img/icon/')
    url.slice!('.gif')
    return url
  end

  def get_date(date_no)
    return @parse_text['forecasts'][date_no]['date']
  end

  def get_city_name
    return @parse_text['location']['city']
  end
end
