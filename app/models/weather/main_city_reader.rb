require 'json'

class MainCityReader
  def read
    file_path = File.expand_path('config/main_city.json', __dir__)

    @city_list = []

    File.open(file_path, 'r') do |text|
      @parse_text = JSON.parse(text.read)

      @parse_text['city'].each { |city|
        @city_list.push(city['name'])
      }
    end
  end

  # 都市名が主要都市一覧に入っているか判断します。
  def contain?(city_name)
    return @city_list.include?(city_name)
  end
end
