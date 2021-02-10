require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @customer = FactoryBot.build(:customer)
  end

  describe 'お客様新規登録' do
    context '新規登録がうまくいくとき' do
      it "全ての情報がが存在すれば登録できる" do
        expect(@customer).to be_valid
      end
      it 'name以外が空欄でも登録できる' do
        @customer.name_kana = ''
        @customer.sex_id = ''
        @customer.tell1 = ''
        @customer.tell2 = ''
        @customer.email = ''
        @customer.address = ''
        @customer.memo = ''
        @customer.appearance = ''
        expect(@customer).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        @customer.name = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include "お名前を入力してください"
      end
      it 'nameが21文字以上では登録できない' do
        @customer.name = 'あいうえおかきくけこさしすせそたちつてとな'
        @customer.valid?
        expect(@customer.errors.full_messages).to include "お名前は20文字以内で入力してください"
      end
    end
  end
end
