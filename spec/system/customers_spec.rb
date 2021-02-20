require 'rails_helper'

RSpec.describe 'お客様登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @customer = FactoryBot.build(:customer)
  end

  context 'お客様情報が登録できるとき' do
    it 'ログインしたユーザーはお客様登録できる' do
      # ログインする
      sign_in(@user)
      # お客様登録ページボタンがあることを確認する
      expect(page).to have_content('お客様新規登録')
      # お客様登録ページに移動する
      visit new_customer_path
      # フォームに情報を入力する
      fill_in 'お名前', with: @customer.name
      fill_in 'お名前カナ', with: @customer.name_kana
      select '男性', from: '性別'
      fill_in '電話番号-1', with: @customer.tell1
      fill_in 'メールアドレス', with: @customer.email
      fill_in '住所', with: @customer.address
      fill_in 'メモ', with: @customer.memo
      fill_in '外見情報', with: @customer.appearance
      # 登録するとCustomerモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Customer.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページに先ほど登録したお客様が存在することを確認する
      expect(page).to have_content(@customer.name)
    end
  end

  context 'お客様情報が登録できないとき' do
    it 'ログインしていないとお客様登録ページに遷移できない' do
      # ログインページに遷移する
      visit new_user_session_path
      # お客様登録のボタンがない
      expect(page).to have_no_content('お客様新規登録')
    end
  end
end

RSpec.describe 'お客様詳細', type: :system do
  before do
    @customer = FactoryBot.create(:customer)
  end

  it 'ログインしたユーザーはお客様の詳細ページに遷移できる' do
    # ログインする
    sign_in(@customer.user)
    # お客様のリンクを押すと詳細ページが表示されることを確認する
    expect(page).to have_link @customer.name.to_s, href: customer_path(@customer)
    # 詳細ページに移動する
    visit customer_path(@customer)
    # 詳細ページにお客様情報の内容が含まれている
    expect(page).to have_content(@customer.name.to_s)
    expect(page).to have_content(@customer.name_kana.to_s)
    expect(page).to have_content(@customer.sex_id.to_s)
    expect(page).to have_content(@customer.tell1.to_s)
    expect(page).to have_content(@customer.address.to_s)
    expect(page).to have_content(@customer.memo.to_s)
    expect(page).to have_content(@customer.appearance.to_s)
  end

  it 'ログインしていないとお客様の詳細ページに遷移できない' do
    # ログイン画面に移動する
    visit new_user_session_path
    # 詳細ページのリンクがないことを確認する
    expect(page).to have_no_link @customer.name.to_s, href: customer_path(@customer)
  end
end

RSpec.describe 'お客様編集', type: :system do
  before do
    @customer = FactoryBot.create(:customer)
  end

  context 'お客様を編集できるとき' do
    it 'ログインしたユーザーは自分が登録したお客様を編集できる' do
      # ログインする
      sign_in(@customer.user)
      # お客様詳細ページへ移動する
      visit customer_path(@customer)
      # お客様の編集ボタンがあることを確認する
      expect(page).to have_link 'お客様編集', href: edit_customer_path(@customer)
      # 編集ページへ遷移する
      visit edit_customer_path(@customer)
      # すでに入力済の内容がフォームに入っていることを確認する
      expect(
        find('#customer_name').value
      ).to eq(@customer.name)
      expect(
        find('#customer_name_kana').value
      ).to eq(@customer.name_kana)
      expect(
        find('#item-category').value.to_i
      ).to eq(@customer.sex_id)
      expect(
        find('#customer_tell1').value
      ).to eq(@customer.tell1)
      expect(
        find('#customer_email').value
      ).to eq(@customer.email)
      expect(
        find('#customer_address').value
      ).to eq(@customer.address)
      expect(
        find('#customer_memo').value
      ).to eq(@customer.memo)
      expect(
        find('#customer_appearance').value
      ).to eq(@customer.appearance)
      # お客様情報を編集する
      fill_in 'customer_memo', with: "#{@customer.memo}+編集したテキスト"
      # 編集してもCustomerモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Customer.count }.by(0)
      # お客様詳細ページに遷移したことを確認する
      expect(current_path).to eq(customer_path(@customer))
      # トップページに先ほど変更した内容のお客様が存在することを確認する
      expect(page).to have_content("#{@customer.memo}+編集したテキスト")
    end
  end

  context 'お客様情報が編集できないとき' do
    it 'ログインしていないとお客様編集画面には遷移できない' do
      # ログイン画面に移動する
      visit new_user_session_path
      # ログイン画面に編集ボタンが無いことを確認する
      expect(page).to have_no_content('お客様編集')
    end
  end
end

RSpec.describe 'お客様削除', type: :system do
  before do
    @customer = FactoryBot.create(:customer)
  end

  context 'お客様の削除ができるとき' do
    it 'ログインしたユーザーは自分が登録したお客様の削除ができる' do
      # ログインする
      sign_in(@customer.user)
      # お客様詳細ページへ移動する
      visit customer_path(@customer)
      # お客様削除ボタンがあることを確認する
      expect(page).to have_link 'お客様削除', href: customer_path(@customer)
      # お客様を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('お客様削除', href: customer_path(@customer)).click
      end.to change { Customer.count }.by(-1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにはお客様1の内容が存在しないことを確認する
      expect(page).to have_no_content(@customer.name.to_s)
    end
  end

  context 'お客様の削除ができないとき' do
    it 'ログインしていないとお客様の削除ボタンがない' do
      # ログインページに移動する
      visit new_user_session_path
      # ログインページにお客様削除ボタンがないことを確認する
      expect(page).to have_no_link 'お客様削除', href: customer_path(@customer)
    end
  end
end
