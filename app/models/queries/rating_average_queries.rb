module Queries

  class RatingAverageQueries

    class << self
      def average_rating(post_id)
        Rating.where(post_id: post_id)
        .average( :mark)
        .to_f
        .round(2)
      end
    end
  end
end
