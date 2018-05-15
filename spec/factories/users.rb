FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@folky.com" }
    password "password"
    password_confirmation "password"
    first_name "User"
    last_name "Last"
  end
end
