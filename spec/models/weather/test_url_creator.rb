require_relative '../../rails_helper'
require_relative '../../../app/models/weather/url_creator'

describe 'WebAPI用URL作成' do
  context '地点のURL作成' do
    it '東京のURL作成' do
      creator = URLCreator.new
      url = creator.create(400_010)
      expected_url = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=400010'
      expect(expected_url).to eq(url)
    end
  end
end
