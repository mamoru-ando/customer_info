class Order < ApplicationRecord
  belongs_to :customer

  with_options presence: true do
    validates :date
    validates :people, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :pay, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
  end

end
