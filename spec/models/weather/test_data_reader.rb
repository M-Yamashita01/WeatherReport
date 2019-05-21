require_relative '../../rails_helper'
require_relative 'mock/data_reader_mock'

describe '天気データ取得' do
  context '今日の情報' do
    it '日付取得' do
      url = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'
      reader = DataReaderMock.new
      reader.read(url)
      expect(Date.today.strftime('%Y-%m-%d')).to eq(reader.get_date(0))
    end
  end
end
