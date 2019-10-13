require 'rails_helper'

RSpec.describe "CurrentWeatherDatas", type: :request do
  describe "GET /current_weather_datas" do
    it "works! (now write some real specs)" do
      get '/api/current_weather_datas'
      expect(response).to have_http_status(200)
    end
  end
end
