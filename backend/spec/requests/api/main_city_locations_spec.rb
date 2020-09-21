# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MainCityLocations', type: :request do
  describe 'GET /api/main_city_locations' do
    context '主要都市を取得する場合' do
      it '主要都市11件取得できることこと' do
        get '/api/main_city_locations'
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
        expect(json['main_city'].length).to eq 11
      end
    end
  end
end
