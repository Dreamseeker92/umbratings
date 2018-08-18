module Queries

  class RatingAverageQueries

    attr_reader :post_id

    def initialize(post_id)
      @post_id = post_id
    end

    def average_rating
      Rating.where(post_id: post_id)
      .average( :mark)
      .to_f
      .round(2)
    end
  end
end
