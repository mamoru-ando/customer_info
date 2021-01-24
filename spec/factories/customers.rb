FactoryBot.define do
  factory :customer do
    name                  { "竈門　炭治郎" }
  association :user
  end
end