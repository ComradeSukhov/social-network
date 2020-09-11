require 'faker'

FactoryBot.define do
  factory :user do
    # Upcased email required for models/user_spec.rb test
    first_name { Faker::Name.first_name }
     last_name { Faker::Name.last_name }
         email { Faker::Internet.unique.email.upcase }
      password { Faker::Internet.password }
  end
end
