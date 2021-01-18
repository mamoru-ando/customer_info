class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex

  has_many :orders, dependent: :destroy
  has_one :appearance
  belongs_to :user

  with_options presence: true do
    validates :last_name
    validates :first_name
  end
end
