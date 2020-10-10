# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecast, type: :model do
  context '現在を表すレコードを入れた場合' do
    let(:location) { create(:tokyo) }
    let(:forecast) { create(:forecast, :current, weathermap_location_id: location.id) }

    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '分ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo) }
    let(:forecast) { create(:forecast, :minutely, weathermap_location_id: location.id) }

    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '時間ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo) }
    let(:forecast) { create(:forecast, :hourly, weathermap_location_id: location.id) }

    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '日ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo) }
    let(:forecast) { create(:forecast, :daily, weathermap_location_id: location.id) }

    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '適当な文字(hogehoge)のレコードを入れた場合' do
    let(:location) { create(:tokyo) }
    let(:forecast) {
      location.forecasts.create(forecast_datetime: DateTime.now,
                                forecast_type: 'hogehoge',
                                weathermap_location_id: location.id)
    }

    it 'validationがpassしないこと' do
      expect(forecast).not_to be_valid
    end
  end

  describe 'scope' do
    describe 'search_current_forecast_by_location' do
      let(:location_tokyo) { create(:tokyo) }

      subject { Forecast.search_current_forecast_by_location(location_tokyo.id) }

      context '現在の天気予報を持つ地域idが1件ある場合' do
        let!(:forecast) { create(:forecast, :current, weathermap_location_id: location_tokyo.id) }

        it '取得できるレコード数が1件であること' do
          expect(subject.count).to eq 1
        end
      end

      context '現在の天気予報を持つ地域idが複数ある場合' do
        let(:location_osaka) { create(:osaka) }
        let!(:forecast_tokyo) { create(:forecast, :current, weathermap_location_id: location_tokyo.id) }
        let!(:forecast_osaka) { create(:forecast, :minutely, weathermap_location_id: location_osaka.id) }

        it '取得できるレコード数が1件であること' do
          expect(subject.count).to eq 1
        end
      end

      context '分ごとの天気予報を持つ地域idが1件ある場合' do
        let!(:forecast) { create(:forecast, :minutely, weathermap_location_id: location_tokyo.id) }

        it '取得できるレコード数が0件であること' do
          expect(subject.count).to eq 0
        end
      end

      context '時間ごとの天気予報を持つ地域idが1件ある場合' do
        let!(:forecast) { create(:forecast, :hourly, weathermap_location_id: location_tokyo.id) }

        it '取得できるレコード数が0件であること' do
          expect(subject.count).to eq 0
        end
      end

      context '日ごとの天気予報を持つ地域idが1件ある場合' do
        let!(:forecast) { create(:forecast, :daily, weathermap_location_id: location_tokyo.id) }

        it '取得できるレコード数が0件であること' do
          expect(subject.count).to eq 0
        end
      end
    end

    describe 'search_daily_forecast_by_location' do
      let(:location_tokyo) { create(:tokyo) }

      subject { Forecast.search_daily_forecast_by_location(location_tokyo.id) }

      context '週の天気予報を持つ地域idが1件ある場合' do
        let(:now_datetime) { DateTime.now }
        let!(:current_forecast) { create(:forecast, :daily, weathermap_location_id: location_tokyo.id) }
        let!(:current_sunriseset) { current_forecast.sunrisesets.create(sunrise_at: now_datetime) }

        it '取得できるレコード数が1件であること' do
          expect(subject.count).to eq 1
        end

        it '日の出時刻が一致していること' do
          expect(subject.first.sunrise_at.to_i).to eq now_datetime.to_i
        end
      end
    end
  end
end
