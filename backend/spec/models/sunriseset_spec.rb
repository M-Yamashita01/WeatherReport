# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sunriseset, type: :model do
  let(:location) { create(:tokyo) }
  let!(:forecast) { create(:forecast, :current, weathermap_location_id: location.id) }

  context '日の出時刻を入れた場合' do
    let(:sunrise) { forecast.sunrisesets.create(sunrise_at: DateTime.now, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(sunrise).to be_valid
    end
  end

  context '日の入時刻を入れた場合' do
    let(:sunset) { forecast.sunrisesets.create(sunset_at: DateTime.now, forecast_id: forecast.id) }

    it '正常に登録されること' do
      expect(sunset).to be_valid
    end
  end
end
