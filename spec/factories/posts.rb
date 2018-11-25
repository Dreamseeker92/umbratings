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
    factory :post_with_ratings do
      after :create do |p|
        10.times { Rating.create(post: p, mark: Array(1..5).sample) }
      end
    end
  end


end