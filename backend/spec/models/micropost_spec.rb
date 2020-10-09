# frozen_string_literal: true

require 'rails_helper'

describe Micropost do
  context '投稿データが存在する場合' do
    let(:user) { create(:test_user) }
    let!(:micropost) { build(:sunny_comment, user: user) }

    it 'validationがpassすること' do
      expect(micropost).to be_valid
    end
  end

  describe '投稿データのユーザが存在しない場合' do
    let(:user) { create(:test_user) }
    let!(:micropost) { build(:sunny_comment, user: user) }

    it 'validationがpassしないこと' do
      micropost.user_id = nil
      expect(micropost).not_to be_valid
    end
  end

  describe '投稿データのコンテンツが存在しない場合' do
    let(:user) { create(:test_user) }
    let!(:micropost) { build(:sunny_comment, user: user) }

    it 'validationがpassしないこと' do
      micropost.content = ''
      expect(micropost).not_to be_valid
    end
  end

  describe '投稿データのコンテンツが文字数オーバーの場合' do
    let(:user) { create(:test_user) }
    let!(:micropost) { build(:sunny_comment, user: user) }

    it 'validationがpassしないこと' do
      micropost.content = 'a' * 141
      expect(micropost).not_to be_valid
    end
  end
end
