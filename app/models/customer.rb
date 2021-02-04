class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex

  has_many :orders, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20, message: 'は20文字以内で入力してください' }
  validates :name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。' }
  with_options format: { with: /\A\d{10,11}\z/, allow_blank: true, message: 'はハイフンなしで入力してください' } do
    validates :tell1
    validates :tell2
  end
end
