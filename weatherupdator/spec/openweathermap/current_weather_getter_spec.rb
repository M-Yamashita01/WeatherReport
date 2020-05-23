require "rails_helper"

RSpec.describe CurrentWeathersGetter do
  describe "天気情報取得" do
    it "APIキーがない場合" do
      current_weather = CurrentWeathersGetter.new
      expect(current_weather).to  be_empty
    end
  end
end