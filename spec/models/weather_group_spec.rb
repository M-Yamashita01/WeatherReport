require 'rails_helper'

RSpec.describe WeatherGroup, type: :model do
  before(:each) do
    @weather_group = FactoryBot.create(:weather_sunny)
  end

  describe '天気グループでの必要なデータが存在する場合' do
    it 'validationがpassすること' do
      expect(@weather_group).to be_valid
    end
  end

  describe '天気グループのidが存在する場合' do
    it 'validationがpassしないこと' do
      @weather_group.weather_group_id = nil
      expect(@weather_group).not_to be_valid
    end
  end

  describe '天気グループのiconが存在しない場合' do
    it 'validationがpassしないこと' do
      @weather_group.weather_icon = ''
      expect(@weather_group).not_to be_valid
    end
  end

  describe '天気グループの概要文が存在しない場合' do
    it 'validationがpassしないこと' do
      @weather_group.weather_main = ''
      expect(@weather_group).not_to be_valid
    end
  end

  describe '天気グループの説明文が存在しない場合' do
    it 'validationがpassしないこと' do
      @weather_group.weather_description = ''
      expect(@weather_group).not_to be_valid
    end
  end
end