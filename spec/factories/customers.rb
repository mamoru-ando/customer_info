FactoryBot.define do
  factory :customer do
    name                  { '竈門　炭治郎' }
    name_kana             { 'カマド タンジロウ' }
    sex_id                { Faker::Number.within(range: 0..3) }
    tell1                 { Faker::PhoneNumber.subscriber_number(length: 11) }
    email                 { Faker::Internet.email }
    address               { Faker::Address.city }
    memo                  { Faker::Lorem.characters(number: 10) }
    appearance            { Faker::Lorem.characters(number: 10) }

    association :user
  end
end
