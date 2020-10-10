# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeathermapLocation, type: :model do
  describe 'validation' do
    context '地域情報が存在する場合' do
      let(:location) { create(:tokyo) }

      it 'validationがpassすること' do
        expect(location).to be_valid
      end
    end

    context '地域情報の地域idが存在しない場合' do
      let(:location) { create(:tokyo) }

      it 'validationがpassしないこと' do
        location.city_id = nil
        expect(location).not_to be_valid
      end
    end

    context '地域情報の緯度が存在しない場合' do
      let(:location) { create(:tokyo) }

      it 'validationがpassしないこと' do
        location.latitude = nil
        expect(location).not_to be_valid
      end
    end

    context '地域情報の経度が存在しない場合' do
      let(:location) { create(:tokyo) }

      it 'validationがpassしないこと' do
        location.longitude = nil
        expect(location).not_to be_valid
      end
    end

    context '地域情報の英語名が存在しない場合' do
      let(:location) { create(:tokyo) }

      it 'validationがpassしないこと' do
        location.city_name = ''
        expect(location).not_to be_valid
      end
    end

    context '地域情報の日本語名が存在しない場合' do
      let(:location) { create(:tokyo) }

      it 'validationがpassすること' do
        location.city_name_ja = ''
        expect(location).to be_valid
      end
    end
  end

  describe 'scope' do
    describe '#search_location' do
      let!(:location_tokyo) { create(:tokyo) }
      let!(:location_osaka) { create(:osaka) }

      subject { WeathermapLocation.search_location(latitude, longitude) }

      context 'テーブルに存在する緯度、経度が与えられた場合' do
        let(:latitude) { 139.691 }
        let(:longitude) { 35.689 }

        it '取得したレコードが1件であること' do
          expect(subject.count).to eq(1)
        end

        it '取得したレコードの緯度、経度が一致していること' do
          expect(subject.first.latitude.to_digits).to eq('139.691')
          expect(subject.first.longitude.to_digits).to eq('35.689')
        end
      end

      context 'テーブルに存在しない緯度、経度が与えられた場合' do
        let(:latitude) { 0 }
        let(:longitude) { 0 }

        it '取得したレコードが0件であること' do
          expect(subject.count).to eq(0)
        end
      end

      context '緯度、経度が両方空文字の場合' do
        let(:latitude) { '' }
        let(:longitude) { '' }

        it '取得したレコードが0件であること' do
          expect(subject.count).to eq(0)
        end
      end

      context '緯度のみ片方空文字の場合' do
        let(:latitude) { '' }
        let(:longitude) { 0 }

        it '取得したレコードが0件であること' do
          expect(subject.count).to eq(0)
        end
      end

      context '経度のみ片方空文字の場合' do
        let(:latitude) { 0 }
        let(:longitude) { '' }

        it '取得したレコードが0件であること' do
          expect(subject.count).to eq(0)
        end
      end

      context '緯度、経度が適当な文字の場合' do
        let(:latitude) { 'hogehoge' }
        let(:longitude) { 'hogehoge' }

        it '取得したレコードが0件であること' do
          expect(subject.count).to eq(0)
        end
      end
    end
  end
end
