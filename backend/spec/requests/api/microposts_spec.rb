# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Micropost', type: :request do
  describe 'GET /api/microposts?user_id' do
    context '1ユーザが1件投稿済みの場合' do
      let(:user) { create(:user) }
      let!(:micropost) { create(:sunny_comment, user: user) }

      it '指定ユーザの投稿した内容が取得できる' do
        get "/api/microposts?user_id=#{user.id}"
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
        expect(json['micropost'].length).to eq 1
        expect(json['micropost'][0]['user_id']).to eq user.id
        expect(json['micropost'][0]['content']).to eq micropost.content
      end
    end

    context '複数ユーザが複数投稿済みの場合' do
      let(:user) { create(:user) }
      let(:test_user) { create(:test_user) }

      let!(:user_micropost) { create_list(:sunny_comment, 10, user: user) }
      let!(:test_user_micropost) { create_list(:cloudy_comment, 10, user: test_user) }

      it '指定ユーザの投稿した内容が取得できる' do
        get "/api/microposts?user_id=#{test_user.id}"
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
        expect(json['micropost'].length).to eq 10
        range = 0..9
        range.each { |i| expect(json['micropost'][i]['user_id']).to eq test_user.id }
      end
    end
  end

  describe 'DELETE /api/micropost/id' do
    context 'ユーザ登録したユーザが投稿している場合' do
      let(:user) { create(:user) }
      let!(:micropost) { create(:rainy_comment, user: user) }

      it '指定した記事の削除ができること' do
        api = "/api/microposts/ + #{micropost.id}"
        expect do
          delete api
        end.to change { Micropost.count }.by(-1)

        expect(response.status).to eq 200
      end
    end
  end

  describe '#create' do
    context 'ユーザ登録済みのユーザの場合' do
      let(:user) { create(:user) }

      it '記事の投稿ができること' do
        params = {
          user_id: user.id,
          content: 'test content'
        }

        post '/api/microposts/', params: params
        expect(response.status).to eq 200
      end
    end
  end
end
