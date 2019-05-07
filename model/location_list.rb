class LocationList
  def initialize
    @array = Array.new
  end

  # location: Locationクラス
  def add(location)
    @array.push(location)
  end

  def count
    return @array.count
  end

  def get
    return @array.pop
  end
end
