require 'rails_helper'

RSpec.describe "CurrentForecasts", type: :request do
  describe "GET /current_forecasts" do
    it "works! (now write some real specs)" do
      get current_forecasts_path
      expect(response).to have_http_status(200)
    end
  end
end
