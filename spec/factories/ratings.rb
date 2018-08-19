FactoryBot.define do
  factory :rating do
    mark { Faker::Number.between(1, 5) }
    post
  end
end