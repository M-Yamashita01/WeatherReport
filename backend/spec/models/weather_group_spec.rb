# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherGroup, type: :model do
  describe 'validation' do
    let(:location) { create(:tokyo) }
    let(:forecast) { location.forecasts.create(forecast_type: "current") }
    let(:weather_group) { create(:weather_sunny, forecast_id: forecast.id) }

    context '天気グループでの必要なデータが存在する場合' do
      it 'validationがpassすること' do
        expect(weather_group).to be_valid
      end
    end

    context '天気グループのidが存在しない場合' do
      it 'validationがpassしないこと' do
        weather_group.weather_group_id = nil
        expect(weather_group).not_to be_valid
      end
    end

    context '天気グループのiconが存在しない場合' do
      it 'validationがpassしないこと' do
        weather_group.weather_icon = ''
        expect(weather_group).not_to be_valid
      end
    end

    context '天気グループの概要文が存在しない場合' do
      it 'validationがpassしないこと' do
        weather_group.weather_main = ''
        expect(weather_group).not_to be_valid
      end
    end

    context '天気グループの説明文が存在しない場合' do
      it 'validationがpassしないこと' do
        weather_group.weather_description = ''
        expect(weather_group).not_to be_valid
      end
    end
  end
end
