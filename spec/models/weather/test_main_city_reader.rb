require_relative '../../rails_helper'
require_relative '../../../app/models/weather/main_city_reader'

describe '主要地点取得' do
  context '主要地点の含み有無' do
    it '東京は主要地点か' do
      reader = MainCityReader.new
      reader.read
      expect(true).to be reader.contain?('東京')
    end

    it '千葉は主要地点か' do
      reader = MainCityReader.new
      reader.read
      expect(false).to be reader.contain?('千葉')
    end
  end

  context '地方の主要地点の含み有無' do
    it '熊本は主要地点か' do
      reader = MainCityReader.new
      reader.read_in_area('kyusyu')
      expect(true).to be reader.contain?('熊本')
    end
  end
end
