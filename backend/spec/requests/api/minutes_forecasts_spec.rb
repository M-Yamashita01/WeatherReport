require 'rails_helper'

RSpec.describe "MinutesForecasts", type: :request do
  describe "GET /minutes_forecasts" do
    it "works! (now write some real specs)" do
      get minutes_forecasts_path
      expect(response).to have_http_status(200)
    end
  end
end
