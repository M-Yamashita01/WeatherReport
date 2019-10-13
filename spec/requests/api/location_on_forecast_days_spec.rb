require 'rails_helper'

RSpec.describe "LocationOnForecastDays", type: :request do
  describe "GET /location_on_forecast_days" do
    it "works! (now write some real specs)" do
      get '/api/location_on_forecast_days'
      expect(response).to have_http_status(200)
    end
  end
end
