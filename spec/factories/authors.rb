FactoryBot.define do
  factory :author do
    login { Faker::Dota.hero }
  end
end