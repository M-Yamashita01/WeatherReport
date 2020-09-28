require 'rails_helper'

RSpec.describe Forecast, type: :model do
  context '現在を表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "current", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '分ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "minutely", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '時間ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "hourly", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '日ごとを表すレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "daily", weathermap_location_id: location.id) }
    it 'validationがpassすること' do
      expect(forecast).to be_valid
    end
  end

  context '適当な文字(hogehoge)のレコードを入れた場合' do
    let(:location) { create(:tokyo)}
    let(:forecast) { location.forecasts.create(forecast_type: "hogehoge", weathermap_location_id: location.id) }
    it 'validationがpassしないこと' do
      expect(forecast).not_to be_valid
    end
  end

  describe 'scope' do
    describe 'search_current_forecast_by_location' do
      let(:location_tokyo) { create(:tokyo) }

      subject { Forecast.search_current_forecast_by_location(location_id) }

      context '現在の天気予報を持つ地域idが1件ある場合' do
        let(:location_id) { location_tokyo.id}
        let!(:forecast) { location_tokyo.forecasts.create(forecast_type: "current") }

        it '取得できるレコード数が1件であること' do
          expect(subject.count).to eq 1
        end
      end

      context '現在の天気予報を持つ地域idが複数ある場合' do
        let(:location_osaka) { create(:osaka) }
        let(:location_id) { location_tokyo.id}
        let!(:forecast_tokyo) { location_tokyo.forecasts.create(forecast_type: "current") }
        let!(:forecast_osaka) { location_osaka.forecasts.create(forecast_type: "current") }

        it '取得できるレコード数が1件であること' do
          expect(subject.count).to eq 1
        end
      end

      context '分ごとの天気予報を持つ地域idが1件ある場合' do
        let(:location_id) { location_tokyo.id}
        let!(:forecast) { location_tokyo.forecasts.create(forecast_type: "minutes") }

        it '取得できるレコード数が0件であること' do
          expect(subject.count).to eq 0
        end
      end

      context '時間ごとの天気予報を持つ地域idが1件ある場合' do
        let(:location_id) { location_tokyo.id}
        let!(:forecast) { location_tokyo.forecasts.create(forecast_type: "hourly") }

        it '取得できるレコード数が0件であること' do
          expect(subject.count).to eq 0
        end
      end

      context '日ごとの天気予報を持つ地域idが1件ある場合' do
        let(:location_id) { location_tokyo.id}
        let!(:forecast) { location_tokyo.forecasts.create(forecast_type: "daily") }

        it '取得できるレコード数が0件であること' do
          expect(subject.count).to eq 0
        end
      end
    end
  end
end
