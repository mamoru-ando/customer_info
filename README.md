# customer_infoのREADME

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


### Association
- has_many :orders
- has_one :appearance


## ordersテーブル
| Column     | Type       | Option            | 
| ---------- | ---------- | ----------------- | 
| date       | data       | null: false       | 
| people     | integer    | null: false       | 
| table      | string     |                   | 
| drink      | string     |                   | 
| food       | string     |                   | 
| pay        | integer    | null: false       | 
| order_memo | string     |                   | 
| customer   | references | foreign_key: true | 

### Association
- belongs_to :customer
