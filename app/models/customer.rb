class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex

  has_many :orders, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20, message: 'は20文字以内で入力してください' }
  with_options format: { with: /\A\d{10,11}\z/, allow_blank: true, message: 'はハイフンなしで入力してください' } do
    validates :tell1
    validates :tell2
  end
end
