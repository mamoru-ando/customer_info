<div align="center">
<img src="https://raw.githubusercontent.com/mamoru-ando/customer_info/3847a61eea0ff01e4bf39a8a68f00eefef90e158/Cliente%E3%83%AD%E3%82%B3%E3%82%99%202021-01-25%2017.47.58.png" alt="Cliente" title="Cliente">
</div>

# Cliente(クリエンテ)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/mamoru-ando/customer_info)

# アプリケーション概要
- お客様の名前が思い出せなくても大丈夫！<br>
  お客様の外見的特徴から検索することで、名前が思い出せない状況を解決する顧客管理アプリケーションです。<br>

![customer](https://user-images.githubusercontent.com/75655307/106693378-ac8bf100-6619-11eb-83e3-6a32ea2759c1.gif)
![order](https://user-images.githubusercontent.com/75655307/106693365-a6961000-6619-11eb-9f10-085bad34af67.gif)
![search](https://user-images.githubusercontent.com/75655307/106693380-ad248780-6619-11eb-944f-f378ad6faf4d.gif)


# URL
- https://cliente-customer-info.herokuapp.com/


# テスト用アカウント
- email: 
- password: 


# 利用方法
- ユーザー（店舗）を登録します
- ログイン後、「お客様新規登録」ボタンからお客様情報を項目に沿って登録できます
- 登録したお客様の名前やメモ、外見の特徴などから検索できます
- 登録したお客様のオーダー（来店）情報を項目に沿って登録できます
- お客様情報やオーダー情報は編集、削除も簡単にできます


# 目指した課題解決
- お名前が思い出せないお客様や名前のわからないお客様も外見の特徴から検索できるので、顧客リストから見つけることができます
- 過去のオーダー情報により前回と違った料理の提案や、お客様の好みや嫌いなもの、アレルギーなどを記録しておくことで、顧客満足度の向上に役立てることができます
- スタッフ間の引継ぎもスムーズに行えるようになります


# 洗い出した要件
- ユーザー（店舗）登録ができます
- お客様情報を登録、編集、削除できます
- 各お客様のオーダー（来店）情報を登録、編集、削除ができます
- 登録したお客様の情報を検索できます
- お客様一覧で最終来店日の表示ができるようになります
- 登録、編集、オーダー登録したお客様が最上部へ表示されます
- ひらがな、カタカナのどちらでも検索できるようにします


# 実装した機能について
- ユーザー（店舗）登録ができます
- お客様情報を登録、編集、削除できます
- 各お客様のオーダー（来店）情報を登録、編集、削除ができます
- 登録したお客様の情報を検索できます
- お客様一覧で最終来店日の表示をできるようにします
- 登録、編集、オーダー登録したお客様が最上部へ表示されます


# 実装予定の機能
- ひらがな、カタカナのどちらでも検索できるようにします


# データベース設計
## ER図
![customer](https://user-images.githubusercontent.com/75655307/106239145-74fdfd00-6245-11eb-81ed-e41f4c417633.png)

## usersテーブル
| Column             | Type   | Option      | 
| ------------------ | ------ | ----------- | 
| name               | string | null: false | 
| email              | string | null: false | 
| encrypted_password | string | null: false | 

### Association
- has_many :customers


## customersテーブル
| Column          | Type       | Option            | 
| --------------- | ---------- | ----------------- | 
| name            | string     | null: false       | 
| name_kana       | string     |                   | 
| sex_id          | integer    |                   | 
| tell1           | string     |                   | 
| tell2           | string     |                   | 
| email           | string     |                   | 
| address         | string     |                   | 
| visit           | integer    |                   | 
| memo            | text       |                   | 
| appearance      | text       |                   | 
| user            | references | foreign_key: true | 

### Association
- has_many :orders
- belongs_to :user


## ordersテーブル
| Column     | Type       | Option            | 
| ---------- | ---------- | ----------------- | 
| date       | data       | null: false       | 
| people     | integer    | null: false       | 
| table      | string     |                   | 
| drink      | string     |                   | 
| food       | string     |                   | 
| pay        | integer    | null: false       | 
| order_memo | text       |                   | 
| customer   | references | foreign_key: true | 

### Association
- belongs_to :customer


# ローカルでの動作方法
- Ruby 2.6.5
- Rails 6.0.0
- DB  MySQL
