require 'rails_helper'

RSpec.describe 'CurrentWeatherDatas', type: :request do
  before(:each) do
    @weathermap_location = FactoryBot.create(:city)
    @weather_group = FactoryBot.create(:weather_sunny)
    @current_weather = FactoryBot.create(:current_weather_sample, weathermap_location: @weathermap_location, weather_group: @weather_group)
  end

  describe 'GET /current_weather_datas' do
    it 'works! (now write some real specs)' do
      get '/api/current_weather_datas'
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['current_weather_data'].length).to eq 1
    end
  end

  describe 'GET /current_weather_datas?longitude_max=&longitude_min=&latitude_max=&latitude_min=' do
    it 'works! (now write some real specs)' do
      get '/api/current_weather_datas?longitude_max=&longitude_min=&latitude_max=&latitude_min='
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['current_weather_data'].length).to eq 1
    end
  end
end
