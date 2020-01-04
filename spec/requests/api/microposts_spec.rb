require 'rails_helper'

RSpec.describe 'Micropost', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @micropost = FactoryBot.create(:sunny_comment, user: @user)
  end

  describe 'GET /api/microposts' do
    it '応答が正常に返ること' do
      get '/api/microposts'
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['micropost'].length).to eq 1
    end
  end

  describe 'GET /api/microposts' do
    it '指定した人のコメントのみ取得できること' do
      test_user = FactoryBot.create(:test_user)
      FactoryBot.create_list(:cloudy_comment, 10, user: test_user)

      api = '/api/microposts?user_id=' + test_user.id.to_s
      get api
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['micropost'].length).to eq 10
    end
  end

  describe "DELETE /api/micropost/id" do
    it "指定した記事の削除ができること" do
      rainy_post = FactoryBot.create(:rainy_comment, user: @user)
      api = '/api/microposts/' + rainy_post.id.to_s
      expect {
        delete api
      }.to change { Micropost.count }.by(-1)
      
      expect(response.status).to eq 200

      
    end
  end
end
