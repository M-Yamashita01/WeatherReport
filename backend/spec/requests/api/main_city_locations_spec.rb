require 'rails_helper'

RSpec.describe 'MainCityLocations', type: :request do
  describe 'GET /api/main_city_locations' do
    it '応答が正常に返ること' do
      get '/api/main_city_locations'
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['main_city'].length).to eq 11
    end
  end
end
