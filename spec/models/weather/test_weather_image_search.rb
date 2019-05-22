require_relative '../../../app/models/weather/weather_image_search'
require_relative '../../rails_helper'

describe '天気画像のパス取得' do
  context '探したい天気の番号' do
    it '天気の番号が存在する' do
      f = WeatherImageSearch.search_from_image_folder(1)
      expect('app/assets/images/1.gif').to eq(f)
    end

    it '天気の番号が存在しない' do
      expect { WeatherImageSearch.search_from_image_folder(100) }.to raise_error(IOError)
    end
  end
end
