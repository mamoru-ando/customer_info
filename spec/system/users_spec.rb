require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザーが新規登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # ログインページへ移動する
      visit root_path
      # ログインページにユーザー登録ボタンがあることを確認する
      expect(page).to have_content('ユーザー登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '店舗名', with: @user.name
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード(確認)', with: @user.password_confirmation
      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # 編集ボタンとログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ユーザー編集')
      expect(page).to have_content('ログアウト')
      # トップページに新規登録ボタンやログインボタンが表示されていないことを確認する
      expect(page).to have_no_content('ユーザー登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー情報が登録できないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # ログインページへ移動する
      visit root_path
      # ログインページにユーザー登録ボタンがあることを確認する
      expect(page).to have_content('ユーザー登録')
      # ユーザー登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '店舗名', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード(確認)', with: ''
      # 登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # ユーザー登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインできる' do
      # ログインページに移動する
      visit root_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ユーザー編集ボタンとログアウトボタンが表示されることを確認する
      expect(page).to have_content('ユーザー編集')
      expect(page).to have_content('ログアウト')
      # ユーザー登録ボタンやログインボタンが表示されていないことを確認する
      expect(page).to have_no_content('ユーザー登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインできない' do
      # ログインページに移動する
      visit root_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
