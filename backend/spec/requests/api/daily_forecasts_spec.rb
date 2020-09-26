require 'rails_helper'

RSpec.describe "DailyForecasts", type: :request do
  describe "GET /api/daily_forecasts" do
    it "works! (now write some real specs)" do
      get api_daily_forecasts_path
      expect(response).to have_http_status(200)
    end
  end
end
