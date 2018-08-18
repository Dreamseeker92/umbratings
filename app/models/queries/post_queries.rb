module Queries

  class PostQueries

    attr_reader :rating, :length

    def initialize(rating, length)
      @rating = rating
      @length = length
    end

    def top_posts
      Post.where(average_rating: rating)
      .order(ratings_count: :desc)
      .first(length)
      .pluck(:title, :body)
    end
  end
end

