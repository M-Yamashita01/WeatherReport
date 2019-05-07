require_relative 'model/url_creator'
require_relative 'model/data_reader'
require_relative 'model/weather_collection'
require_relative 'view/weather_display'
require_relative 'controller/weather_reporter'

class Main
  def self.execute
    creator = URLCreator.new
    reader = DataReader.new
    collection = WeatherCollection.new(creator, reader)
    display = WeatherDisplay.new

    reporter = WeatherReporter.new(collection, display)
    reporter.report_today_weather
  end
end

Main.execute
