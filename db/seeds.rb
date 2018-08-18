  ip_array = []
  authors_array = []

  50.times { ip_array << Faker::Internet.ip_v4_address }

  100.times { authors_array << Author.create(login: Faker::AquaTeenHungerForce.character) }

  200_000.times do
    Post.create(
      title: Faker::FamilyGuy.character,
      body: Faker::ChuckNorris.fact,
      author: authors_array.sample,
      author_ip: ip_array.sample
    )
  end

  post_ids = Post.pluck(:id)

  10_000.times do
    MarkPostWorker.perform_async(
      post_ids.sample,
      Faker::Number.between(1, 5)
    )
  end
