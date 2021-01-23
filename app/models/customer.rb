class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex

  has_many :orders, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
