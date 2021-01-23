class Order < ApplicationRecord
  belongs_to :customer

  with_options presence: true do
    validates :date
    validates :people
    validates :table
    validates :pay, numericality: { only_integer: true, message: 'は半角で入力してください' }
  end

end
