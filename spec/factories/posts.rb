FactoryBot.define do
  factory :post do
    title { Faker::LordOfTheRings.character }
    body { Faker::ChuckNorris.fact }
    author_ip { Faker::Internet.ip_v4_address }
    author

    trait  :empty do
      title ''
      body ''
      author_ip ''
      author_id nil
    end

    factory :empty_post, traits: [:empty]
  end
end