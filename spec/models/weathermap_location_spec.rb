require 'rails_helper'

RSpec.describe WeathermapLocation, type: :model do
  before(:each) do
    @weather_location = FactoryBot.create(:city)
  end

  describe '地域情報が存在する場合' do
    it 'validationがpassすること' do
      expect(@weather_location).to be_valid
    end
  end

  describe '地域情報の地域idが存在しない場合' do
    it 'validationがpassしないこと' do
      @weather_location.city_id = nil
      expect(@weather_location).not_to be_valid
    end
  end
end