require 'rails_helper'

RSpec.describe 'CurrentWeatherDatas', type: :request do
  describe 'GET /current_weather_datas' do
    it 'works! (now write some real specs)' do
      get '/api/current_weather_datas'
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /current_weather_datas?longitude_max=&longitude_min=&latitude_max=&latitude_min=' do
    it 'works! (now write some real specs)' do
      get '/api/current_weather_datas?longitude_max=&longitude_min=&latitude_max=&latitude_min='
      expect(response).to have_http_status(200)
    end
  end
end
