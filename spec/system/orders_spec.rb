require 'rails_helper'

RSpec.describe 'オーダー入力', type: :system do
  before do
    @customer1 = FactoryBot.create(:customer)
    @order = FactoryBot.build(:order)
  end

  it 'ログインしたユーザーはお客様詳細ページでオーダー情報を入力できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'メールアドレス', with: @customer1.user.email
    fill_in 'パスワード', with: @customer1.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # お客様詳細ページへ遷移する
    visit customer_path(@customer1)
    # オーダー情報入力ボタンがあることを確認する
    expect(page).to have_link 'オーダー情報入力', href: new_customer_order_path(@customer1)
    # オーダー入力ページへ遷移する
    visit new_customer_order_path(@customer1)
    # フォームに情報を入力する
    fill_in '来店日', with: @order.date
    fill_in '来店人数', with: @order.people
    fill_in 'テーブル番号', with: @order.table
    fill_in 'ドリンクオーダー', with: @order.drink
    fill_in 'フードオーダー', with: @order.food
    fill_in '支払い金額', with: @order.pay
    fill_in 'メモ', with: @order.order_memo
    # 登録するとOrderモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Order.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(customer_path(@customer1))
    # 詳細ページに先程のオーダー情報が含まれていることを確認する
    expect(page).to have_content(@order.date)
  end

  it 'ログインしていないとオーダー情報を登録できない' do
    # ログインページへ移動する
    visit new_user_session_path
    # ログインページにはオーダー情報入力ボタンがないことを確認する
    expect(page).to have_no_link 'オーダー情報入力', href: new_customer_order_path(@customer1)
  end
end


RSpec.describe 'オーダー編集', type: :system do
  before do
    @order = FactoryBot.create(:order)
  end

  it 'ログインしていればオーダー情報を編集できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'メールアドレス', with: @order.customer.user.email
    fill_in 'パスワード', with: @order.customer.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # お客様詳細ページへ遷移する
    visit customer_path(@order.customer_id)
    # オーダー編集ボタンがあることを確認する
    expect(page).to have_link '編集', href: edit_customer_order_path(@order.customer_id, @order.id)
    # オーダー編集ページへ移動する
    visit edit_customer_order_path(@order.customer_id, @order.id)
    # 登録したオーダー情報が入力されていることを確認する
    expect(
      find('#order_date').value
    ).to eq("#{@order.date}")
    expect(
      find('#order_people').value
    ).to eq("#{@order.people}")
    expect(
      find('#order_table').value
    ).to eq(@order.table)
    expect(
      find('#order_drink').value
    ).to eq(@order.drink)
    expect(
      find('#order_food').value
    ).to eq(@order.food)
    expect(
      find('#order_pay').value
    ).to eq("#{@order.pay}")
    expect(
      find('#order_order_memo').value
    ).to eq(@order.order_memo)
    # オーダーを編集する
    fill_in 'order_order_memo', with: "#{@order.order_memo}+編集したテキスト"
    # 登録してもOrderモデルのカウントは変わらないことを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Order.count }.by(0)
    # お客様詳細ページへ遷移したことを確認する
    expect(current_path).to eq(customer_path(@order.customer))
    # 編集した内容が表示されていることを確認する
    expect(page).to have_content("#{@order.order_memo}+編集したテキスト")
  end

  it 'ログインしていないとオーダー情報は編集できない' do
    # ログインページへ移動する
    visit new_user_session_path
    # ログインページにはオーダー編集ボタンはないことを確認する
    expect(page).to have_no_link '編集', href: edit_customer_order_path(@order.customer_id, @order.id)
  end
end


RSpec.describe 'オーダー削除', type: :system do
  before do
    @order = FactoryBot.create(:order)
  end

  it 'ログインしているとオーダー情報が削除できる' do
    # ログインページへ移動する
    visit new_user_session_path
    fill_in 'メールアドレス', with: @order.customer.user.email
    fill_in 'パスワード', with: @order.customer.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # お客様詳細ページへ遷移する
    visit customer_path(@order.customer_id)
    # オーダー削除ボタンがあることを確認する
    expect(page).to have_link '削除', href: customer_order_path(@order.customer_id, @order.id)
    # お客様を削除するとレコードの数が1減ることを確認する
    expect{
      find_link('削除', href: customer_order_path(@order.customer_id, @order.id)).click
    }.to change { Order.count }.by(-1)
    # お客様詳細ページへ遷移したことを確認する
    expect(current_path).to eq(customer_path(@order.customer_id))
    # 編集した内容が表示されていることを確認する
    expect(page).to have_no_content("#{@order.date}")
  end

  it 'ログインしているとオーダー情報が削除できる' do
    # ログインページへ移動する
    visit new_user_session_path
    # ログインページにはオーダー削除ボタンがないことを確認する
    expect(page).to have_no_link '削除', href: customer_order_path(@order.customer_id, @order.id)
  end
end