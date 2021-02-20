FactoryBot.define do
  factory :order do
    date              { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    people            { Faker::Number.within(range: 1..10) }
    table             { 'A' + Faker::Number.within(range: 1..10).to_s }
    drink             { Faker::Beer.name }
    food              { Faker::Food.dish }
    pay               { Faker::Number.within(range: 1000..60_000) }
    order_memo        { Faker::Lorem.characters(number: 10) }

    association :customer
  end
end
