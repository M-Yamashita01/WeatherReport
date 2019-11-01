require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  describe 'ユーザが削除された時' do
    it 'ユーザが持つ投稿データが存在しないこと' do
      @user.save
      @user.microposts.create(content: 'test')
      @user.destroy

      expect(Micropost.count).to eq 0
    end
  end
end
