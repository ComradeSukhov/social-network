require 'faker'

FactoryBot.define do
  factory :post do
    body { Faker::Quote.yoda }
  end
end
