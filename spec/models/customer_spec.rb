require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:customer)
  end

  describe 'お客様新規登録' do
    context '新規登録がうまくいくとき' do
      it "nameが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end
      it 'nameが21文字以上では登録できない' do
        @user.name = 'あいうえおかきくけこさしすせそたちつてとな'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は20文字以内で入力してください"
      end
    end
  end
end
