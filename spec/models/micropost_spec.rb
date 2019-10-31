require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @micropost = Micropost.new(content: 'Lorem ipsum', user_id: @user.id)
  end

  describe '投稿データが存在する場合' do
    it 'validationがpassすること' do
      expect(@micropost).to be_valid
    end
  end

  describe '投稿データのユーザが存在しない場合' do
    it 'validationがpassしないこと' do
      @micropost.user_id = nil
      expect(@micropost).not_to be_valid
    end
  end

  describe '投稿データのコンテンツが存在しない場合' do
    it 'validationがpassしないこと' do
      @micropost.content = ''
      expect(@micropost).not_to be_valid
    end
  end

  describe '投稿データのコンテンツが文字数オーバーの場合' do
    it 'validationがpassしないこと' do
      @micropost.content = 'a' * 141
      expect(@micropost).not_to be_valid
    end
  end
end
