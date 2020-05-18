class CurrentWeatherList
  def initialize
    @array = Array.new
  end

  # current_weather: CurrentWeatherクラス
  def add(current_weather)
    @array.push(current_weather)
  end

  def count
    return @array.count
  end

  def get
    return @array.pop
  end
end
