require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:order)
  end

  describe 'オーダー情報の新規登録' do
    context '新規登録がうまくいくとき' do
      it 'date, people, payが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'dateが空だと登録できない' do
        @user.date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '日付を入力してください'
      end
      it 'peopleが空だと登録できない' do
        @user.people = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '人数を入力してください'
      end
      it 'peopleが全角だと登録できない' do
        @user.people = '２'
        @user.valid?
        expect(@user.errors.full_messages).to include '人数は半角数字で入力してください'
      end
      it 'payが空だと登録できない' do
        @user.pay = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '支払い金額を入力してください'
      end
      it 'payeが全角だと登録できない' do
        @user.pay = '２０００'
        @user.valid?
        expect(@user.errors.full_messages).to include '支払い金額は半角数字で入力してください'
      end
    end
  end
end
