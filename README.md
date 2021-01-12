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
| last_name       | string     | null: false       | 
| first_name      | string     | null: false       | 
| last_name_kana  | string     |                   | 
| first_name_kana | string     |                   | 
| sex_id          | integer    |                   | 
| tell1           | string     | null: false       | 
| tell2           | string     |                   | 
| email           | string     |                   | 
| address         | string     |                   | 
| visit           | integer    |                   | 
| memo            | text       |                   | 
| order           | references | foreign_key: true | 
| appearance      | references | foreign_key: true | 

### Association
- has_many :orders
- has_one :appearance


## ordersテーブル
| Column   | Type       | Option            | 
| -------- | ---------- | ----------------- | 
| date     | data       | null: false       | 
| people   | inreger    | null: false       | 
| table    | string     | null: false       | 
| drink    | string     |                   | 
| food     | string     |                   | 
| pay      | integer    | null: false       | 
| tell2    | string     |                   | 
| customer | references | foreign_key: true | 

### Association
- belongs_to :customer


## appearanceテーブル
| Column   | Type       | Option            | 
| -------- | ---------- | ----------------- | 
| text     | string     |                   | 
| customer | references | foreign_key: true | 

### Association
- belongs_to :customer