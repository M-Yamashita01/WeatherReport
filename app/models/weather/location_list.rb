class LocationList
  def initialize
    @array = Array.new
  end

  # location: LocationInformationクラス
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
