require_relative '../../rails_helper'
require_relative '../../../app/models/weather/weatherHack/location_id_reader'
require_relative '../../../app/models/weather/weatherHack/location_list'


describe '地点情報取得' do
  context '地点数' do
    it '全地点数' do
      reader = LocationIdReader.new
      location_list = reader.read_all_location_id
      expect(142).to eq(location_list.count)
    end

    it '主要地点数' do
      reader = LocationIdReader.new
      location_list = reader.read_main_location_id
      expect(21).to eq(location_list.count)
    end

    it '指定地点数' do
      reader = LocationIdReader.new
      location_list = reader.read_location_id_in_area('九州')
      expect(7).to eq(location_list.count)
    end
  end
end
