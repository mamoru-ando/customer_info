class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex

  has_many :orders
  has_one :appearance
  belongs_to :user
end
