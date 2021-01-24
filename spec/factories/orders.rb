FactoryBot.define do
  factory :order do
    date              { Faker::Date.between(from: 2.year.ago, to: Date.today) }
    people            { Faker::Number.within(range: 1..10) }
    pay               { 6000 }

  association :customer
  end
end