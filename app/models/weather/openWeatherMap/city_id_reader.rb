require 'json'
class CityIdReader
  def read_city_id(country_code)
    file_path = File.expand_path('city.list.json', __dir__)
    parse_text = ''
    File.open(file_path, 'r') do |text|
      parse_text = JSON.parse(text.read)
    end

    return parse_text.select { |i| i['country'] == country_code }
  end
end
