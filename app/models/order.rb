class Order < ApplicationRecord
  belongs_to :customer

  with_options presence: true do
    validates :date
    validates :people
    validates :table
    validates :pay
  end

end
